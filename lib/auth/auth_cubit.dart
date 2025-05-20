import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AppAuthState> {
  final _supabase = Supabase.instance.client;

  AuthCubit() : super(AuthInitial()) {
    checkAuthStatus();

    _supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.tokenRefreshed) {
        if (session != null) {
          emit(AuthAuthenticated(userId: session.user.id));
        }
      } else if (event == AuthChangeEvent.signedOut) {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final session = _supabase.auth.currentSession;

      if (session != null) {
        emit(AuthAuthenticated(userId: session.user.id));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        emit(AuthAuthenticated(userId: response.user!.id));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        emit(AuthAuthenticated(userId: response.user!.id));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _supabase.auth.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}