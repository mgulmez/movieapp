import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/common/bloc_event.dart';
import 'package:bloc/bloc.dart';
import 'package:movieapp/extensions.dart';

import '../common/bloc_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

abstract class AccountEvent extends BlocEvent {}

abstract class AccountState extends BlocState {}

class LoginEvent extends AccountEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class ForgotPasswordEvent extends AccountEvent {
  final String email;
  ForgotPasswordEvent(this.email);
}

class ResetPasswordEvent extends AccountEvent {
  final String code;
  final String password;
  ResetPasswordEvent(this.code, this.password);
}

class RegisterEvent extends AccountEvent {
  final String displayName;
  final String email;
  final String password;
  RegisterEvent(this.displayName, this.email, this.password);
}

class LogoutEvent extends AccountEvent {}

class UserLoggedInState extends AccountState {
  final User user;
  UserLoggedInState(this.user);
}

class UserRegisteredState extends AccountState {
  final User user;
  UserRegisteredState(this.user);
}

class PasswordResetCodeSentState extends AccountState {}

class PasswordChangedState extends AccountState {}

class AccountBLOC extends Bloc<AccountEvent, BlocState> {
  AccountBLOC() : super(InitialState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<ForgotPasswordEvent>(_changePasswordRequest);
    on<ResetPasswordEvent>(_resetPassword);
    on<LogoutEvent>(_logout);
  }
  void _login(LoginEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (user.user != null) {
        emit(UserLoggedInState(user.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(e.message!.tr));
    }
  }

  void _register(RegisterEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (user.user != null) {
        emit(UserRegisteredState(user.user!));
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString().tr));
    }
  }

  void _changePasswordRequest(
      ForgotPasswordEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    try {
      await _auth.sendPasswordResetEmail(
        email: event.email,
      );
      emit(PasswordResetCodeSentState());
    } on Exception catch (e) {
      emit(ErrorState(e.toString().tr));
    }
  }

  void _resetPassword(ResetPasswordEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    try {
      await _auth.confirmPasswordReset(
          code: event.code, newPassword: event.password);
      emit(PasswordChangedState());
    } on Exception catch (e) {
      emit(ErrorState(e.toString().tr));
    }
  }

  void _logout(LogoutEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    await _auth.signOut();
    emit(InitialState());
  }
}
