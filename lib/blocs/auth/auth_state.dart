part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String msgT, msgC;

  const AuthFailedState(this.msgT, this.msgC);

  @override
  List<Object> get props => [msgT, msgC];
}
