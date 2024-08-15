part of 'legal_cases_page_bloc.dart';

enum LegalCasesPageStatus {
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
  caseLoading,
  caseSuccess,
  caseEdit,
  caseError,
  downloading,
  downloaded,
  downloadError,
}

extension LegalCasesPageStatusX on LegalCasesPageStatus {
  bool get isInitial => this == LegalCasesPageStatus.initial;

  bool get isSuccess => this == LegalCasesPageStatus.success;

  bool get isLoading => this == LegalCasesPageStatus.loading;

  bool get isError => this == LegalCasesPageStatus.error;

  bool get isNotFound => this == LegalCasesPageStatus.notFound;

  bool get isEmpty => this == LegalCasesPageStatus.empty;

  bool get isPosting => this == LegalCasesPageStatus.posting;

  bool get isPosted => this == LegalCasesPageStatus.posted;

  bool get isPostError => this == LegalCasesPageStatus.postError;

  bool get isDeleting => this == LegalCasesPageStatus.deleting;

  bool get isDeleted => this == LegalCasesPageStatus.deleted;

  bool get isDeleteError => this == LegalCasesPageStatus.deleteError;

  bool get isCaseLoading => this == LegalCasesPageStatus.caseLoading;

  bool get isCaseSuccess => this == LegalCasesPageStatus.caseSuccess;

  bool get isCaseError => this == LegalCasesPageStatus.caseError;

  bool get isCaseEdit => this == LegalCasesPageStatus.caseEdit;

  bool get isDownloading => this == LegalCasesPageStatus.downloading;

  bool get isDownloaded => this == LegalCasesPageStatus.downloaded;

  bool get isDownloadError => this == LegalCasesPageStatus.downloadError;
}

@immutable
class LegalCasesPageState extends Equatable {
  final List<LegalCase>? legalCases;
  final LegalCasesPageStatus status;
  final LegalCase? legalCase;

  const LegalCasesPageState({
    this.legalCases,
    this.status = LegalCasesPageStatus.initial,
    this.legalCase,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        legalCases,
        status,
        legalCase,
      ];

  LegalCasesPageState copyWith({
    List<LegalCase>? legalCases,
    LegalCasesPageStatus? status,
    LegalCase? legalCase,
    bool? isLegalCaseLoading,
    String? message,
  }) {
    return LegalCasesPageState(
      legalCases: legalCases ?? this.legalCases,
      status: status ?? this.status,
      legalCase: legalCase ?? this.legalCase,
    );
  }
}
