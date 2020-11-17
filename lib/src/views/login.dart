import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ium_warehouse/routing/routes.dart';
import 'package:ium_warehouse/src/logic/cubit/auth/auth_cubit.dart';
import 'package:ium_warehouse/src/ui/app_colors.dart';
import 'package:ium_warehouse/src/ui/app_fonts.dart';
import 'package:ium_warehouse/src/widgets/customFormField.dart';
import 'package:ium_warehouse/src/widgets/custom_toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.red]),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sign in",
                      style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 72),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if(state is AuthStateSuccess) {
                          Navigator.pushReplacementNamed(context, AppRoute.dashboard.name);
                        } else if(state is AuthStateError) {
                          if(state.error.startsWith("success"))
                            CustomToast(
                              "Email and password don't match.",
                              Icons.error_outline,
                              Colors.redAccent,
                            ).show(context);
                          else  CustomToast(
                            "No connection",
                            Icons.error_outline,
                            Colors.redAccent,
                          ).show(context);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600].withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 12,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: AppColors.notWhite),
                              color: AppColors.notWhite,
                              borderRadius: BorderRadius.all(Radius.circular(18.0))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 8),
                                  child: CustomFormField('Email', Icons.mail_outline,onSaved: (val) => _email = val, isEmail: false, validator: validateEmail,)),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32.0, 8, 32, 8),
                                  child: CustomFormField('Password', Icons.lock_outline, onSaved:(val) => _password = val, isHidden: true, validator: validatePassword,)),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [ Colors.red[300], AppColors.accentColor],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(18.0)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Icon(Icons.login_outlined, color: AppColors.moreWhite, size: 32,),
                                              ),
                                              Text(
                                                "LOGIN",
                                                textAlign: TextAlign.center,
                                                style: AppFonts.buttonFont,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: onButtonPress,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Divider()
                                    ),
                                    Text("OR"),
                                    Expanded(
                                      child: Divider()
                                    ),
                                  ]
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [ Colors.blue[300], Colors.blue[600]],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(18.0)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Image.asset('assets/images/google_logo.png', height: 32, width: 32, fit: BoxFit.fitWidth,),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "LOGIN WITH GOOGLE",
                                                  textAlign: TextAlign.center,
                                                  style: AppFonts.buttonFont,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: onSignIn,
                                  ),
                                )
                              ],
                            )),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void onButtonPress() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<AuthCubit>(context).loginUser(_email, _password);
    } else {
      CustomToast(
        "Invalid data",
        Icons.clear_outlined,
        Colors.redAccent,
      ).show(context);
    }
  }

  String validateEmail(String email) {
    RegExp _email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(!_email.hasMatch(email))
      return "Invalid email";
    else return null;
  }

  String validatePassword(String pass) {
    if(pass.length > 4) {
      return null;
    }
    return "Password too short";
  }

  void onSignIn() {
    BlocProvider.of<AuthCubit>(context).loginGoogle();
  }
}
