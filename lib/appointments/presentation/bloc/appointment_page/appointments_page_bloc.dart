import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Variables/app_runtime_values.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/appointment.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/attorney_availability.dart';
import 'package:dirm_attorneys_mobile/appointments/data/repository/implementation/appointment_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'appointments_page_event.dart';
part 'appointments_page_state.dart';

class AppointmentsPageBloc
    extends Bloc<AppointmentsPageEvent, AppointmentsPageState> {
  AppointmentsPageBloc() : super(const AppointmentsPageState()) {
    on<LoadAppointmentsEvent>(_mapFetchAppointmentsToState);
    on<LoadAttorneyAvailabilityEvent>(_mapLoadAttorneyAvailabilityToState);
    on<AddAppointmentEvent>(_mapAddAppointmentToState);
    on<UpdateAppointmentEvent>(_mapUpdateAppointmentToState);
    on<LoadSingleAppointmentEvent>(_mapLoadSingleAppointmentToState);
    on<DeleteAppointmentEvent>(_mapDeleteAppointmentToState);
    on<CancelAppointmentEvent>(_mapCancelAppointmentToState);
  }

  _mapFetchAppointmentsToState(
      LoadAppointmentsEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .getAllAppointments(authData.data!.token!)
          .then((appointments) {
        if (appointments.isNotEmpty) {
          emit(state.copyWith(
              status: AppointmentsPageStatus.success,
              appointments: appointments));
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
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapLoadAttorneyAvailabilityToState(LoadAttorneyAvailabilityEvent event,
      Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .getAttorneyAvailability(authData.data!.token!, event.id)
          .then((attorneyAvailability) {
        if (attorneyAvailability.isNotEmpty) {
          emit(state.copyWith(
              status: AppointmentsPageStatus.success,
              attorneyAvailability: attorneyAvailability));
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
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapAddAppointmentToState(
      AddAppointmentEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.postLoading));
    try {
      await AppointmentRepoImpl()
          .postAppointment(authData.data!.token!, event.appointment)
          .then((attorneyAvailability) {
        emit(state.copyWith(status: AppointmentsPageStatus.postSuccess));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: AppointmentsPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapUpdateAppointmentToState(
      UpdateAppointmentEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .putAppointment(authData.data!.token!, event.appointment)
          .then((attorneyAvailability) {
        emit(state.copyWith(status: AppointmentsPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: AppointmentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapLoadSingleAppointmentToState(LoadSingleAppointmentEvent event,
      Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .getAppointment(authData.data!.token!, event.slug)
          .then((appointment) {
        emit(state.copyWith(
            status: AppointmentsPageStatus.success, appointment: appointment));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: AppointmentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDeleteAppointmentToState(
      DeleteAppointmentEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .deleteAppointment(authData.data!.token!, event.slug)
          .then((appointment) {
        emit(state.copyWith(status: AppointmentsPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: AppointmentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapCancelAppointmentToState(
      CancelAppointmentEvent event, Emitter<AppointmentsPageState> emit) async {
    emit(state.copyWith(status: AppointmentsPageStatus.loading));
    try {
      await AppointmentRepoImpl()
          .cancelAppointment(authData.data!.token!, event.slug)
          .then((appointment) {
        emit(state.copyWith(status: AppointmentsPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: AppointmentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: AppointmentsPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
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
