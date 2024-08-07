import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/legal_case.dart';
import '../../../data/repository/implementation/legal_case_repo_impl.dart';

part 'legal_cases_page_event.dart';
part 'legal_cases_page_state.dart';

class LegalCasesPageBloc
    extends Bloc<LegalCasesPageEvent, LegalCasesPageState> {
  LegalCasesPageBloc() : super(const LegalCasesPageState()) {
    on<RefreshLegalCasesEvent>(_mapRefreshLegalCasesToState);
    on<LoadLegalCasesEvent>(_mapFetchLegalCasesToState);
    on<LegalCasePostEvent>(_mapPostLegalCaseToState);
  }

  _mapRefreshLegalCasesToState(
      RefreshLegalCasesEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.loading));
    try {
      await LegalCaseRepoImpl()
          .getAllLegalCases(authData.data!.token!)
          .then((legalCases) {
        if (legalCases.isNotEmpty) {
          emit(state.copyWith(
              status: LegalCasesPageStatus.success, legalCases: legalCases));
        } else {
          emit(state.copyWith(status: LegalCasesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapFetchLegalCasesToState(
      LoadLegalCasesEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.loading));
    try {
      await LegalCaseRepoImpl()
          .getAllLegalCases(authData.data!.token!)
          .then((legalCases) {
        if (legalCases.isNotEmpty) {
          emit(state.copyWith(
              status: LegalCasesPageStatus.success, legalCases: legalCases));
        } else {
          emit(state.copyWith(status: LegalCasesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapPostLegalCaseToState(
      LegalCasePostEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.posting));
    try {
      await LegalCaseRepoImpl()
          .postLegalCase(authData.data!.token!, event.legalCase)
          .then((response) {
        emit(state.copyWith(status: LegalCasesPageStatus.posted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(LegalCasesPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<LegalCasesPageEvent, LegalCasesPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LegalCasesPageState> change) {
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
