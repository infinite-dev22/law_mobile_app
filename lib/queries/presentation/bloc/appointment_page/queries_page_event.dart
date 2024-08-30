part of 'queries_page_bloc.dart';

sealed class QueriesPageEvent extends Equatable {
  const QueriesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadQueriesEvent extends QueriesPageEvent {}

class LoadAttorneyAvailabilityEvent extends QueriesPageEvent {
  final int id;

  const LoadAttorneyAvailabilityEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddQueryEvent extends QueriesPageEvent {
  final Query query;

  const AddQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateQueryEvent extends QueriesPageEvent {
  final Query query;

  const UpdateQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadSingleQueryEvent extends QueriesPageEvent {
  final int queryId;

  const LoadSingleQueryEvent(this.queryId);

  @override
  List<Object?> get props => [queryId];
}

class DeleteQueryEvent extends QueriesPageEvent {
  final int queryId;

  const DeleteQueryEvent(this.queryId);

  @override
  List<Object?> get props => [queryId];
}

class CancelQueryEvent extends QueriesPageEvent {
  final int queryId;

  const CancelQueryEvent(this.queryId);

  @override
  List<Object?> get props => [queryId];
}

class QueryAddedEvent extends QueriesPageEvent {}
