part of 'publications_page_bloc.dart';

enum PublicationsPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
}

extension PublicationsPageStatusX on PublicationsPageStatus {
  bool get isInitial => this == PublicationsPageStatus.initial;

  bool get isSuccess => this == PublicationsPageStatus.success;

  bool get isLoading => this == PublicationsPageStatus.loading;

  bool get isError => this == PublicationsPageStatus.error;

  bool get isNotFound => this == PublicationsPageStatus.notFound;

  bool get isEmpty => this == PublicationsPageStatus.empty;
}

@immutable
class PublicationsPageState extends Equatable {
  final List<Publication>? publications;
  final PublicationsPageStatus status;
  final Publication? publication;

  const PublicationsPageState({
    this.publications,
    this.status = PublicationsPageStatus.initial,
    this.publication,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    publications,
    status,
    publication,
  ];

  PublicationsPageState copyWith({
    List<Publication>? publications,
    PublicationsPageStatus? status,
    Publication? publication,
    bool? isPublicationLoading,
    String? message,
  }) {
    return PublicationsPageState(
      publications: publications ?? this.publications,
      status: status ?? this.status,
      publication: publication ?? this.publication,
    );
  }
}