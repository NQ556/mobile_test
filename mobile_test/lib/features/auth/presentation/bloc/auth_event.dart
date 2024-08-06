part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent({
    required this.email,
    required this.password,
  });
}

final class GetUserEvent extends AuthEvent {}

final class LogOutEvent extends AuthEvent {}
