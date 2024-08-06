part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState(this.user);
}

final class AuthLogOutSuccessState extends AuthState {}

final class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState(this.message);
}

final class AuthIsNotLoggedInState extends AuthState {}
