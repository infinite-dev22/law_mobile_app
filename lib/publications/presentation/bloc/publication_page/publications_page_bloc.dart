import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/publication.dart';
import '../../../data/repository/implementation/publication_repo_impl.dart';

part 'publications_page_event.dart';
part 'publications_page_state.dart';

class PublicationsPageBloc
    extends Bloc<PublicationsPageEvent, PublicationsPageState> {
  PublicationsPageBloc() : super(const PublicationsPageState()) {
    on<RefreshPublicationsEvent>(_mapRefreshPublicationsToState);
    on<LoadPublicationsEvent>(_mapFetchPublicationsToState);
    on<PublicationPostEvent>(_mapPostPublicationToState);
    on<DeletePublicationEvent>(_mapDeletePublicationToState);
    on<GetPublicationEvent>(_mapGetPublicationToState);
    on<DownloadPublicationEvent>(_mapDownloadPublicationToState);
  }

  _mapRefreshPublicationsToState(RefreshPublicationsEvent event,
      Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.loading));
    try {
      await PublicationRepoImpl()
          .getAllPublications(authData.data!.token!)
          .then((publications) {
        if (publications.isNotEmpty) {
          emit(state.copyWith(
              status: PublicationsPageStatus.success,
              publications: publications));
        } else {
          emit(state.copyWith(status: PublicationsPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapFetchPublicationsToState(
      LoadPublicationsEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.loading));
    try {
      await PublicationRepoImpl()
          .getAllPublications(authData.data!.token!)
          .then((publications) {
        if (publications.isNotEmpty) {
          emit(state.copyWith(
              status: PublicationsPageStatus.success,
              publications: publications));
        } else {
          emit(state.copyWith(status: PublicationsPageStatus.empty));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapPostPublicationToState(
      PublicationPostEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.posting));
    try {
      await PublicationRepoImpl()
          .postPublication(authData.data!.token!, event.publication)
          .then((response) {
        emit(state.copyWith(status: PublicationsPageStatus.posted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.postError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.postError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDeletePublicationToState(
      DeletePublicationEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.deleting));
    try {
      await PublicationRepoImpl()
          .deletePublication(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: PublicationsPageStatus.deleted));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.deleteError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.deleteError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapGetPublicationToState(
      GetPublicationEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.publicationLoading));
    try {
      await PublicationRepoImpl()
          .getPublication(authData.data!.token!, event.slug)
          .then((publication) {
        emit(event.edit
            ? state.copyWith(
                status: PublicationsPageStatus.publicationEdit,
                publication: publication)
            : state.copyWith(
                status: PublicationsPageStatus.publicationSuccess,
                publication: publication));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.publicationError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.publicationError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDownloadPublicationToState(DownloadPublicationEvent event,
      Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.downloading));
    try {
      await PublicationRepoImpl()
          .downloadPublication(authData.data!.token!, event.slug)
          .then((response) {
        emit(state.copyWith(status: PublicationsPageStatus.downloaded));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: PublicationsPageStatus.downloadError));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: PublicationsPageStatus.downloadError));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(PublicationsPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<PublicationsPageEvent, PublicationsPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PublicationsPageState> change) {
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
