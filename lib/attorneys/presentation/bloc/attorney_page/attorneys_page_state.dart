part of 'attorneys_page_bloc.dart';

enum AttorneysPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
}

extension AttorneysPageStatusX on AttorneysPageStatus {
  bool get isInitial => this == AttorneysPageStatus.initial;

  bool get isSuccess => this == AttorneysPageStatus.success;

  bool get isLoading => this == AttorneysPageStatus.loading;

  bool get isError => this == AttorneysPageStatus.error;

  bool get isNotFound => this == AttorneysPageStatus.notFound;

  bool get isEmpty => this == AttorneysPageStatus.empty;
}

@immutable
class AttorneysPageState extends Equatable {
  final List<Attorney>? attorneys;
  final AttorneysPageStatus status;
  final Attorney? attorney;

  const AttorneysPageState({
    this.attorneys,
    this.status = AttorneysPageStatus.initial,
    this.attorney,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    attorneys,
    status,
    attorney,
  ];

  AttorneysPageState copyWith({
    List<Attorney>? attorneys,
    AttorneysPageStatus? status,
    Attorney? attorney,
    bool? isAttorneyLoading,
    String? message,
  }) {
    return AttorneysPageState(
      attorneys: attorneys ?? this.attorneys,
      status: status ?? this.status,
      attorney: attorney ?? this.attorney,
    );
  }
}