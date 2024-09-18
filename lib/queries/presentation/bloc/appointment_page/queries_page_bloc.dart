import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Variables/app_runtime_values.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';
import 'package:dirm_attorneys_mobile/queries/data/repository/implementation/query_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'queries_page_event.dart';
part 'queries_page_state.dart';

class QueriesPageBloc extends Bloc<QueriesPageEvent, QueriesPageState> {
  QueriesPageBloc() : super(const QueriesPageState()) {
    on<LoadQueriesEvent>(_mapFetchQueriesToState);
    on<AddQueryEvent>(_mapAddQueryToState);
    on<UpdateQueryEvent>(_mapUpdateQueryToState);
    on<LoadSingleQueryEvent>(_mapLoadSingleQueryToState);
    on<DeleteQueryEvent>(_mapDeleteQueryToState);
  }

  _mapFetchQueriesToState(
      LoadQueriesEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    try {
      await QueryRepoImpl()
          .getAllQueries(authData.data!.token!)
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
    } catch (e) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapAddQueryToState(
      AddQueryEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    try {
      await QueryRepoImpl()
          .postQuery(authData.data!.token!, event.query)
          .then((attorneyAvailability) {
        emit(state.copyWith(status: QueriesPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: QueriesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapUpdateQueryToState(
      UpdateQueryEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    try {
      await QueryRepoImpl()
          .putQuery(authData.data!.token!, event.query)
          .then((attorneyAvailability) {
        emit(state.copyWith(status: QueriesPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: QueriesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapLoadSingleQueryToState(
      LoadSingleQueryEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    try {
      await QueryRepoImpl()
          .getQuery(authData.data!.token!, event.queryId)
          .then((query) {
        emit(state.copyWith(status: QueriesPageStatus.success, query: query));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: QueriesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  _mapDeleteQueryToState(
      DeleteQueryEvent event, Emitter<QueriesPageState> emit) async {
    emit(state.copyWith(status: QueriesPageStatus.loading));
    try {
      await QueryRepoImpl()
          .deleteQuery(authData.data!.token!, event.queryId)
          .then((query) {
        emit(state.copyWith(status: QueriesPageStatus.success));
      }).onError((error, stackTrace) {
        emit(state.copyWith(status: QueriesPageStatus.error));
        if (kDebugMode) {
          log("Error: $error");
          log("Stacktrace: $stackTrace");
        }
      });
    } catch (e) {
      emit(state.copyWith(status: QueriesPageStatus.error));
      if (kDebugMode) {
        log("Error: $e");
      }
    }
  }

  @override
  void onEvent(QueriesPageEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<QueriesPageEvent, QueriesPageState> transition) {
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
