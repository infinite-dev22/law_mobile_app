import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/legal_certificate.dart';
import '../../../data/repository/implementation/legal_certificate_repo_impl.dart';

part 'legal_certificates_page_event.dart';
part 'legal_certificates_page_state.dart';

class LegalCertificatesPageBloc
    extends Bloc<LegalCertificatesPageEvent, LegalCertificatesPageState> {
  LegalCertificatesPageBloc() : super(const LegalCertificatesPageState()) {
    on<RefreshLegalCertificatesEvent>(_mapRefreshLegalCertificatesToState);
    on<LoadLegalCertificatesEvent>(_mapFetchLegalCertificatesToState);
    on<LegalCertificatePostEvent>(_mapPostLegalCertificateToState);
    on<DeleteLegalCertificateEvent>(_mapDeleteLegalCertificateToState);
    on<GetLegalCertificateEvent>(_mapGetLegalCertificateToState);
    on<DownloadLegalCertificateEvent>(_mapDownloadLegalCertificateToState);
  }

  _mapRefreshLegalCertificatesToState(RefreshLegalCertificatesEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(state.copyWith(status: LegalCertificatesPageStatus.loading));
    try {
      await LegalCertificateRepoImpl()
          .getAllLegalCertificates(authData.data!.token!)
          .then((certificates) {
        if (certificates.isNotEmpty) {
          emit(state.copyWith(
              status: LegalCertificatesPageStatus.success,
              certificates: certificates));
        } else {
          emit(state.copyWith(status: LegalCertificatesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCertificatesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapFetchLegalCertificatesToState(LoadLegalCertificatesEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(state.copyWith(status: LegalCertificatesPageStatus.loading));
    try {
      await LegalCertificateRepoImpl()
          .getAllLegalCertificates(authData.data!.token!)
          .then((certificates) {
        if (certificates.isNotEmpty) {
          emit(state.copyWith(
              status: LegalCertificatesPageStatus.success,
              certificates: certificates));
        } else {
          emit(state.copyWith(status: LegalCertificatesPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCertificatesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapPostLegalCertificateToState(LegalCertificatePostEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(state.copyWith(status: LegalCertificatesPageStatus.posting));
    try {
      await LegalCertificateRepoImpl()
          .postLegalCertificate(authData.data!.token!, event.legalCertificate)
          .then((response) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.posted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCertificatesPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDeleteLegalCertificateToState(DeleteLegalCertificateEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(state.copyWith(status: LegalCertificatesPageStatus.deleting));
    try {
      await LegalCertificateRepoImpl()
          .deleteLegalCertificate(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.deleted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.deleteError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCertificatesPageStatus.deleteError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapGetLegalCertificateToState(GetLegalCertificateEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(
        state.copyWith(status: LegalCertificatesPageStatus.certificateLoading));
    try {
      await LegalCertificateRepoImpl()
          .getLegalCertificate(authData.data!.token!, event.slug)
          .then((certificate) {
        emit(event.edit
            ? state.copyWith(
                status: LegalCertificatesPageStatus.certificateEdit,
                certificate: certificate)
            : state.copyWith(
                status: LegalCertificatesPageStatus.certificateSuccess,
                certificate: certificate));
      }).onError((error, stackTrace) {
        emit(state.copyWith(
            status: LegalCertificatesPageStatus.certificateError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(
          state.copyWith(status: LegalCertificatesPageStatus.certificateError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDownloadLegalCertificateToState(DownloadLegalCertificateEvent event,
      Emitter<LegalCertificatesPageState> emit) async {
    emit(state.copyWith(status: LegalCertificatesPageStatus.downloading));
    try {
      await LegalCertificateRepoImpl()
          .downloadLegalCertificate(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.downloaded));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: LegalCertificatesPageStatus.downloadError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: LegalCertificatesPageStatus.downloadError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(LegalCertificatesPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<LegalCertificatesPageEvent, LegalCertificatesPageState>
          transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<LegalCertificatesPageState> change) {
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
