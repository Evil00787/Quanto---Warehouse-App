import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ium_warehouse/src/models/json/json_user.dart';
import 'package:ium_warehouse/src/models/ui/user.dart';
import 'package:ium_warehouse/src/services/db/users_rep.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository = GetIt.I<UserRepository>();
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  bool wasGoogle;

  AuthCubit(this._googleSignIn, this._auth) : super(AuthStateInitial());

  Future<void> loginUser(String email, String password) async {
    JsonUser user = JsonUser(email: email, password: password);
    dynamic response = await _userRepository.login(user);
    if(response is bool) {
      if(response) emit(AuthStateError('connection' + DateTime.now().toString()));
      else emit(AuthStateError('success' + DateTime.now().toString()));
    }
    else emit(AuthStateSuccess(response as UIUser));
    wasGoogle = false;
  }

  Future<void> logoutUser() async {
    dynamic response = await _userRepository.logout();
    if(wasGoogle)
      await _googleSignIn.signOut();
    if(response)
      emit(AuthStateInitial());
  }

  Future<void> loginGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;



    if (user != null) {
      assert(!user.isAnonymous);
      String token = await user.getIdToken();
      assert(token != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      JsonUser jsonUser = JsonUser(email: user.email, idToken: token);
      dynamic response = await _userRepository.login(jsonUser);
      if(response is bool) {
        if(response) emit(AuthStateError('connection' + DateTime.now().toString()));
        else emit(AuthStateError('success' + DateTime.now().toString()));
      }
      else emit(AuthStateSuccess(response as UIUser));

      wasGoogle = true;
      return '$user';
    }

    return null;
  }

  void firebaseInit() async {
    await Firebase.initializeApp();
  }

}
