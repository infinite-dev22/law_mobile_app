import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/attorney.dart';
import '../../../data/repository/implementation/attorney_repo_impl.dart';

part 'attorneys_page_event.dart';
part 'attorneys_page_state.dart';

class AttorneysPageBloc
    extends Bloc<AttorneysPageEvent, AttorneysPageState> {
  AttorneysPageBloc() : super(const AttorneysPageState()) {
    on<RefreshAttorneysEvent>(_mapRefreshAttorneysToState);
    on<LoadAttorneysEvent>(_mapFetchAttorneysToState);
  }

  _mapRefreshAttorneysToState(
      RefreshAttorneysEvent event, Emitter<AttorneysPageState> emit) async {
    emit(state.copyWith(status: AttorneysPageStatus.loading));
    await AttorneyRepoImpl()
        .getAllAttorneys(currentUserToken)
        .then((attorneys) {
      if (attorneys.isNotEmpty) {
        emit(state.copyWith(
            status: AttorneysPageStatus.success, attorneys: attorneys));
      } else {
        emit(state.copyWith(status: AttorneysPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: AttorneysPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchAttorneysToState(
      LoadAttorneysEvent event, Emitter<AttorneysPageState> emit) async {
    emit(state.copyWith(status: AttorneysPageStatus.loading));
    await AttorneyRepoImpl()
        .getAllAttorneys(currentUserToken)
        .then((attorneys) {
      if (attorneys.isNotEmpty) {
        emit(state.copyWith(
            status: AttorneysPageStatus.success, attorneys: attorneys));
      } else {
        emit(state.copyWith(status: AttorneysPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: AttorneysPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(AttorneysPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<AttorneysPageEvent, AttorneysPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<AttorneysPageState> change) {
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
