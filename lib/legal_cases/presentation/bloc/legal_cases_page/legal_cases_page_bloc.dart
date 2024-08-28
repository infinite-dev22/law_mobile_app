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
    on<LegalCasePutEvent>(_mapPutLegalCaseToState);
    on<DeleteLegalCaseEvent>(_mapDeleteLegalCaseToState);
    on<GetLegalCaseEvent>(_mapGetLegalCaseToState);
    on<DownloadLegalCaseEvent>(_mapDownloadLegalCaseToState);
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

  _mapPutLegalCaseToState(
      LegalCasePutEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.posting));
    try {
      await LegalCaseRepoImpl()
          .putLegalCase(authData.data!.token!, event.legalCase)
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

  _mapDeleteLegalCaseToState(
      DeleteLegalCaseEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.deleting));
    try {
      await LegalCaseRepoImpl()
          .deleteLegalCase(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: LegalCasesPageStatus.deleted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.deleteError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.deleteError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapGetLegalCaseToState(
      GetLegalCaseEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.caseLoading));
    try {
      await LegalCaseRepoImpl()
          .getLegalCase(authData.data!.token!, event.slug)
          .then((legalCase) {
        emit(event.edit
            ? state.copyWith(
                status: LegalCasesPageStatus.caseEdit, legalCase: legalCase)
            : state.copyWith(
                status: LegalCasesPageStatus.caseSuccess,
                legalCase: legalCase));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.caseError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.caseError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDownloadLegalCaseToState(
      DownloadLegalCaseEvent event, Emitter<LegalCasesPageState> emit) async {
    emit(state.copyWith(status: LegalCasesPageStatus.downloading));
    try {
      await LegalCaseRepoImpl()
          .downloadLegalCase(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: LegalCasesPageStatus.downloaded));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCasesPageStatus.downloadError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCasesPageStatus.downloadError));
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
