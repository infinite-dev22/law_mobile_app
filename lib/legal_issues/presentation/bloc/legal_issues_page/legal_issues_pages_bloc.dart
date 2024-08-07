import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/legal_issue.dart';
import '../../../data/repository/implementation/legal_issue_repo_impl.dart';

part 'legal_issues_pages_event.dart';
part 'legal_issues_pages_state.dart';

class LegalIssuesPagesBloc
    extends Bloc<LegalIssuesPageEvent, LegalIssuesPageState> {
  LegalIssuesPagesBloc() : super(const LegalIssuesPageState()) {
    on<RefreshLegalIssuesEvent>(_mapRefreshLegalIssuesToState);
    on<LoadLegalIssuesEvent>(_mapFetchLegalIssuesToState);
    on<LegalIssuePostEvent>(_mapPostLegalIssueToState);
  }

  _mapRefreshLegalIssuesToState(
      RefreshLegalIssuesEvent event, Emitter<LegalIssuesPageState> emit) async {
    emit(state.copyWith(status: LegalIssuesPageStatus.loading));
    try {
      await LegalIssueRepoImpl()
          .getAllLegalIssues(authData.data!.token!)
          .then((issues) {
        if (issues.isNotEmpty) {
          emit(state.copyWith(
              status: LegalIssuesPageStatus.success, issues: issues));
        } else {
          emit(state.copyWith(status: LegalIssuesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalIssuesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalIssuesPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapFetchLegalIssuesToState(
      LoadLegalIssuesEvent event, Emitter<LegalIssuesPageState> emit) async {
    emit(state.copyWith(status: LegalIssuesPageStatus.loading));
    try {
      await LegalIssueRepoImpl()
          .getAllLegalIssues(authData.data!.token!)
          .then((issues) {
        if (issues.isNotEmpty) {
          emit(state.copyWith(
              status: LegalIssuesPageStatus.success, issues: issues));
        } else {
          emit(state.copyWith(status: LegalIssuesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalIssuesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalIssuesPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapPostLegalIssueToState(
      LegalIssuePostEvent event, Emitter<LegalIssuesPageState> emit) async {
    emit(state.copyWith(status: LegalIssuesPageStatus.posting));
    try {
      await LegalIssueRepoImpl()
          .postLegalIssue(authData.data!.token!, event.legalIssue)
          .then((response) {
        emit(state.copyWith(status: LegalIssuesPageStatus.posted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalIssuesPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalIssuesPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(LegalIssuesPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<LegalIssuesPageEvent, LegalIssuesPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LegalIssuesPageState> change) {
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
