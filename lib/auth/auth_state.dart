part of 'auth_cubit.dart';

abstract class AppAuthState {}

class AuthInitial extends AppAuthState {}

class AuthLoading extends AppAuthState {}

class AuthAuthenticated extends AppAuthState {
  final String userId;
  AuthAuthenticated({required this.userId});
}

class AuthUnauthenticated extends AppAuthState {}

class AuthError extends AppAuthState {
  final String message;
  AuthError({required this.message});
}