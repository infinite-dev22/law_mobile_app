import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../Global/Variables/app_runtime_values.dart';
import '../../../data/model/query.dart';
import '../../../data/repository/implementation/query_repo_impl.dart';

part 'queries_page_event.dart';
part 'queries_page_state.dart';

class QueriesPageBloc
    extends Bloc<QueriesPageEvent, QueriesPageState> {
  QueriesPageBloc() : super(const QueriesPageState()) {
    on<RefreshQueriesEvent>(_mapRefreshQueriesToState);
    on<LoadQueriesEvent>(_mapFetchQueriesToState);
  }

  _mapRefreshQueriesToState(
      RefreshQueriesEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    await QueryRepoImpl()
        .getAllQueries(currentUserToken)
        .then((queries) {
      if (queries.isNotEmpty) {
        emit(state.copyWith(
            status: QueriesPageStatus.success, queries: queries));
      } else {
        emit(state.copyWith(status: QueriesPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchQueriesToState(
      LoadQueriesEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    await QueryRepoImpl()
        .getAllQueries(currentUserToken)
        .then((queries) {
      if (queries.isNotEmpty) {
        emit(state.copyWith(
            status: QueriesPageStatus.success, queries: queries));
      } else {
        emit(state.copyWith(status: QueriesPageStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(QueriesPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<QueriesPageEvent, QueriesPageState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<QueriesPageState> change) {
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
