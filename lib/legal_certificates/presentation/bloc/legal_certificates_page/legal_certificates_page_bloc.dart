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
