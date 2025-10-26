import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coresight/models/signin_form_model.dart';
import 'package:coresight/models/user_model.dart';
import 'package:coresight/services/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final user = await AuthService().login(event.data);
          emit(AuthSuccess(user: user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          final SigninFormModel data = await AuthService()
              .getCredentialFromLocal();
          await AuthService().logout(data.toLogoutJson());
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SigninFormModel data = await AuthService()
              .getCredentialFromLocal();
          final user = await AuthService().login(data);
          emit(AuthSuccess(user: user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
