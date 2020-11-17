part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateError extends AuthState {
  final String error;

  AuthStateError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthStateSuccess extends AuthState {
  final UIUser user;

  AuthStateSuccess(this.user);

  @override
  List<Object> get props => [user];
}


