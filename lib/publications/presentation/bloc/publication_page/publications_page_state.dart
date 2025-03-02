part of 'publications_page_bloc.dart';

enum PublicationsPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
  posting,
  posted,
  postError,
  deleting,
  deleted,
  deleteError,
  publicationLoading,
  publicationSuccess,
  publicationEdit,
  publicationError,
  downloading,
  downloaded,
  downloadError,
}

extension PublicationsPageStatusX on PublicationsPageStatus {
  bool get isInitial => this == PublicationsPageStatus.initial;

  bool get isSuccess => this == PublicationsPageStatus.success;

  bool get isLoading => this == PublicationsPageStatus.loading;

  bool get isError => this == PublicationsPageStatus.error;

  bool get isNotFound => this == PublicationsPageStatus.notFound;

  bool get isEmpty => this == PublicationsPageStatus.empty;

  bool get isPosting => this == PublicationsPageStatus.posting;

  bool get isPosted => this == PublicationsPageStatus.posted;

  bool get isPostError => this == PublicationsPageStatus.postError;

  bool get isDeleting => this == PublicationsPageStatus.deleting;

  bool get isDeleted => this == PublicationsPageStatus.deleted;

  bool get isDeleteError => this == PublicationsPageStatus.deleteError;

  bool get isPublicationLoading =>
      this == PublicationsPageStatus.publicationLoading;

  bool get isPublicationSuccess =>
      this == PublicationsPageStatus.publicationSuccess;

  bool get isPublicationError =>
      this == PublicationsPageStatus.publicationError;

  bool get isPublicationEdit => this == PublicationsPageStatus.publicationEdit;

  bool get isDownloading => this == PublicationsPageStatus.downloading;

  bool get isDownloaded => this == PublicationsPageStatus.downloaded;

  bool get isDownloadError => this == PublicationsPageStatus.downloadError;
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
