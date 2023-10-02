part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class DoLoginEvent extends AuthEvent{
  final String email,password;
  final bool isRemember;
  const DoLoginEvent({required this.email, required this.password, required this.isRemember});
  @override
  List<Object> get props => [email,password, isRemember];
}
