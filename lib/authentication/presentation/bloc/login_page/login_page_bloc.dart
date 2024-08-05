import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/login_model.dart';
import '../../../data/repository/implementation/login_repo_impl.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(const LoginPageState()) {
    on<LoginPostEvent>(_mapPostLoginToState);
  }

  _mapPostLoginToState(
      LoginPostEvent event, Emitter<LoginPageState> emit) async {
    emit(state.copyWith(status: LoginPageStatus.loading));
    await LoginRepoImpl()
        .postLogin(currentUserToken, event.loginModel)
        .then((response) {
      emit(state.copyWith(status: LoginPageStatus.success));
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: LoginPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(LoginPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<LoginPageEvent, LoginPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LoginPageState> change) {
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
