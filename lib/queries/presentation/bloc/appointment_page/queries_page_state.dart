part of 'queries_page_bloc.dart';

enum QueriesPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
  posting,
  posted,
  postError,
}

extension QueriesPageStatusX on QueriesPageStatus {
  bool get isInitial => this == QueriesPageStatus.initial;

  bool get isSuccess => this == QueriesPageStatus.success;

  bool get isLoading => this == QueriesPageStatus.loading;

  bool get isError => this == QueriesPageStatus.error;

  bool get isNotFound => this == QueriesPageStatus.notFound;

  bool get isEmpty => this == QueriesPageStatus.empty;

  bool get isPosting => this == QueriesPageStatus.posting;

  bool get isPosted => this == QueriesPageStatus.posted;

  bool get isPostError => this == QueriesPageStatus.postError;
}

@immutable
class QueriesPageState extends Equatable {
  final List<Query>? queries;
  final QueriesPageStatus status;
  final Query? query;

  const QueriesPageState({
    this.queries,
    this.status = QueriesPageStatus.initial,
    this.query,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        queries,
        status,
        query,
      ];

  QueriesPageState copyWith({
    List<Query>? queries,
    QueriesPageStatus? status,
    Query? query,
    bool? isQueryLoading,
    String? message,
  }) {
    return QueriesPageState(
      queries: queries ?? this.queries,
      status: status ?? this.status,
      query: query ?? this.query,
    );
  }
}
