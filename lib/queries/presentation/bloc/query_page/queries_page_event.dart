part of 'queries_page_bloc.dart';

sealed class QueriesPageEvent extends Equatable {
  const QueriesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadQueriesEvent extends QueriesPageEvent {}

class RefreshQueriesEvent extends QueriesPageEvent {}

class LoadSingleQueryEvent extends QueriesPageEvent {
  final int id;

  const LoadSingleQueryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class QueryAddedEvent extends QueriesPageEvent {}
