import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/appointment.dart';
import '../../../data/repository/implementation/appointment_repo_impl.dart';

part 'appointments_page_event.dart';
part 'appointments_page_state.dart';

class AppointmentsPageBloc
    extends Bloc<AppointmentsPageEvent, AppointmentsPageState> {
  AppointmentsPageBloc() : super(const AppointmentsPageState()) {
    on<RefreshAppointmentsEvent>(_mapRefreshAppointmentsToState);
    on<LoadAppointmentsEvent>(_mapFetchAppointmentsToState);
  }

  _mapRefreshAppointmentsToState(
      RefreshAppointmentsEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    await AppointmentRepoImpl()
        .getAllAppointments(currentUserToken)
        .then((appointments) {
      if (appointments.isNotEmpty) {
        emit(state.copyWith(
            status: AppointmentsPageStatus.success, appointments: appointments));
      } else {
        emit(state.copyWith(status: AppointmentsPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchAppointmentsToState(
      LoadAppointmentsEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    await AppointmentRepoImpl()
        .getAllAppointments(currentUserToken)
        .then((appointments) {
      if (appointments.isNotEmpty) {
        emit(state.copyWith(
            status: AppointmentsPageStatus.success, appointments: appointments));
      } else {
        emit(state.copyWith(status: AppointmentsPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(AppointmentsPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<AppointmentsPageEvent, AppointmentsPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<AppointmentsPageState> change) {
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
