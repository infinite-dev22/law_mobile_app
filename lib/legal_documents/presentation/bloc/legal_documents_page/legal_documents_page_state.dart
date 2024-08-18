part of 'legal_documents_page_bloc.dart';

enum LegalDocumentsPageStatus {
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
  documentLoading,
  documentSuccess,
  documentEdit,
  documentError,
  downloading,
  downloaded,
  downloadError,
}

extension LegalDocumentsPageStatusX on LegalDocumentsPageStatus {
  bool get isInitial => this == LegalDocumentsPageStatus.initial;

  bool get isSuccess => this == LegalDocumentsPageStatus.success;

  bool get isLoading => this == LegalDocumentsPageStatus.loading;

  bool get isError => this == LegalDocumentsPageStatus.error;

  bool get isNotFound => this == LegalDocumentsPageStatus.notFound;

  bool get isEmpty => this == LegalDocumentsPageStatus.empty;

  bool get isPosting => this == LegalDocumentsPageStatus.posting;

  bool get isPosted => this == LegalDocumentsPageStatus.posted;

  bool get isPostError => this == LegalDocumentsPageStatus.postError;

  bool get isDeleting => this == LegalDocumentsPageStatus.deleting;

  bool get isDeleted => this == LegalDocumentsPageStatus.deleted;

  bool get isDeleteError => this == LegalDocumentsPageStatus.deleteError;

  bool get isDocumentLoading =>
      this == LegalDocumentsPageStatus.documentLoading;

  bool get isDocumentSuccess =>
      this == LegalDocumentsPageStatus.documentSuccess;

  bool get isDocumentError => this == LegalDocumentsPageStatus.documentError;

  bool get isDocumentEdit => this == LegalDocumentsPageStatus.documentEdit;

  bool get isDownloading => this == LegalDocumentsPageStatus.downloading;

  bool get isDownloaded => this == LegalDocumentsPageStatus.downloaded;

  bool get isDownloadError => this == LegalDocumentsPageStatus.downloadError;
}

@immutable
class LegalDocumentsPageState extends Equatable {
  final List<LegalDocument>? documents;
  final LegalDocumentsPageStatus status;
  final LegalDocument? document;

  const LegalDocumentsPageState({
    this.documents,
    this.status = LegalDocumentsPageStatus.initial,
    this.document,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        documents,
        status,
        document,
      ];

  LegalDocumentsPageState copyWith({
    List<LegalDocument>? documents,
    LegalDocumentsPageStatus? status,
    LegalDocument? document,
    bool? isLegalDocumentLoading,
    String? message,
  }) {
    return LegalDocumentsPageState(
      documents: documents ?? this.documents,
      status: status ?? this.status,
      document: document ?? this.document,
    );
  }
}
