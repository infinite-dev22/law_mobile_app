import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/legal_document.dart';
import '../../../data/repository/implementation/legal_document_repo_impl.dart';

part 'legal_documents_page_event.dart';
part 'legal_documents_page_state.dart';

class LegalDocumentsPageBloc
    extends Bloc<LegalDocumentsPageEvent, LegalDocumentsPageState> {
  LegalDocumentsPageBloc() : super(const LegalDocumentsPageState()) {
    on<RefreshLegalDocumentsEvent>(_mapRefreshLegalDocumentsToState);
    on<LoadLegalDocumentsEvent>(_mapFetchLegalDocumentsToState);
    on<LegalDocumentPostEvent>(_mapPostLegalDocumentToState);
  }

  _mapRefreshLegalDocumentsToState(RefreshLegalDocumentsEvent event,
      Emitter<LegalDocumentsPageState> emit) async {
    emit(state.copyWith(status: LegalDocumentsPageStatus.loading));
    try {
      await LegalDocumentRepoImpl()
          .getAllLegalDocuments(authData.data!.token!)
          .then((documents) {
        if (documents.isNotEmpty) {
          emit(state.copyWith(
              status: LegalDocumentsPageStatus.success, documents: documents));
        } else {
          emit(state.copyWith(status: LegalDocumentsPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalDocumentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalDocumentsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapFetchLegalDocumentsToState(LoadLegalDocumentsEvent event,
      Emitter<LegalDocumentsPageState> emit) async {
    emit(state.copyWith(status: LegalDocumentsPageStatus.loading));
    try {
      await LegalDocumentRepoImpl()
          .getAllLegalDocuments(authData.data!.token!)
          .then((documents) {
        if (documents.isNotEmpty) {
          emit(state.copyWith(
              status: LegalDocumentsPageStatus.success, documents: documents));
        } else {
          emit(state.copyWith(status: LegalDocumentsPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalDocumentsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalDocumentsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapPostLegalDocumentToState(LegalDocumentPostEvent event,
      Emitter<LegalDocumentsPageState> emit) async {
    emit(state.copyWith(status: LegalDocumentsPageStatus.posting));
    try {
      await LegalDocumentRepoImpl()
          .postLegalDocument(authData.data!.token!, event.legalDocument)
          .then((response) {
        emit(state.copyWith(status: LegalDocumentsPageStatus.posted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalDocumentsPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalDocumentsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(LegalDocumentsPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<LegalDocumentsPageEvent, LegalDocumentsPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LegalDocumentsPageState> change) {
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
