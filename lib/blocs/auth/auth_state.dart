part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailed extends AuthState {
  final String e;
  AuthFailed(this.e);

  List<Object> get props => [e];
}

final class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess({required this.user});

  List<Object> get props => [user];
}
