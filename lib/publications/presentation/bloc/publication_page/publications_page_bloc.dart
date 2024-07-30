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
  }

  _mapRefreshPublicationsToState(
      RefreshPublicationsEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.loading));
    await PublicationRepoImpl()
        .getAllPublications(currentUserToken)
        .then((publications) {
      if (publications.isNotEmpty) {
        emit(state.copyWith(
            status: PublicationsPageStatus.success, publications: publications));
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
  }

  _mapFetchPublicationsToState(
      LoadPublicationsEvent event, Emitter<PublicationsPageState> emit) async {
    emit(state.copyWith(status: PublicationsPageStatus.loading));
    await PublicationRepoImpl()
        .getAllPublications(currentUserToken)
        .then((publications) {
      if (publications.isNotEmpty) {
        emit(state.copyWith(
            status: PublicationsPageStatus.success, publications: publications));
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
