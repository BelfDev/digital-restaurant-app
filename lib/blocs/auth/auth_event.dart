part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LogInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogOutRequested extends AuthenticationEvent {}
