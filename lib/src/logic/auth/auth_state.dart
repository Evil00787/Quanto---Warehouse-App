part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateError extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateSuccess extends AuthState {
  @override
  List<Object> get props => [];
}


