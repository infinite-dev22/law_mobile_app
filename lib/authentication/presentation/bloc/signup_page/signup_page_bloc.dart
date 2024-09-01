import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/model/signup_model.dart';
import '../../../data/repository/implementation/login_repo_impl.dart';

part 'signup_page_event.dart';
part 'signup_page_state.dart';

class SignUpPageBloc extends Bloc<SignUpPageEvent, SignUpPageState> {
  SignUpPageBloc() : super(const SignUpPageState()) {
    on<SignUpPostEvent>(_mapPostSignUpToState);
  }

  _mapPostSignUpToState(
      SignUpPostEvent event, Emitter<SignUpPageState> emit) async {
    emit(state.copyWith(status: SignUpPageStatus.loading));
    try {
      if(event.loginModel.password == event.loginModel.confirmPassword) {
        await LoginRepoImpl().postSignUp(event.loginModel).then((value) {
          emit(
            state.copyWith(
                status: SignUpPageStatus.success,
                message: "User Created Successfully"),
          );
        }).onError((error, stackTrace) {
          if (error.toString().contains("401")) {
            emit(
              state.copyWith(
                  status: SignUpPageStatus.error, message: "An error occurred"),
            );
          } else {
            emit(
              state.copyWith(
                  status: SignUpPageStatus.error, message: "An error occurred"),
            );
          }
          if (kDebugMode) {
            log("Error: $error");
            log("Stacktrace: $stackTrace");
          }
        });
      } else {
        emit(
          state.copyWith(
              status: SignUpPageStatus.error, message: "Passwords do not match"),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: SignUpPageStatus.error, message: "An error occurred"),
      );
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(SignUpPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<SignUpPageEvent, SignUpPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<SignUpPageState> change) {
    log(change.toString());
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log(error.toString());
    log(stackTrace.toString());
    super.onError(error, stackTrace);
  }
}
