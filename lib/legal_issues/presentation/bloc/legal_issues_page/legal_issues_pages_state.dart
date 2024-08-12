part of 'legal_issues_pages_bloc.dart';

enum LegalIssuesPageStatus {
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
  issueLoading,
  issueSuccess,
  issueError,
  downloading,
  downloaded,
  downloadError,
}

extension LegalIssuesPageStatusX on LegalIssuesPageStatus {
  bool get isInitial => this == LegalIssuesPageStatus.initial;

  bool get isSuccess => this == LegalIssuesPageStatus.success;

  bool get isLoading => this == LegalIssuesPageStatus.loading;

  bool get isError => this == LegalIssuesPageStatus.error;

  bool get isNotFound => this == LegalIssuesPageStatus.notFound;

  bool get isEmpty => this == LegalIssuesPageStatus.empty;

  bool get isPosting => this == LegalIssuesPageStatus.posting;

  bool get isPosted => this == LegalIssuesPageStatus.posted;

  bool get isPostError => this == LegalIssuesPageStatus.postError;

  bool get isDeleting => this == LegalIssuesPageStatus.deleting;

  bool get isDeleted => this == LegalIssuesPageStatus.deleted;

  bool get isDeleteError => this == LegalIssuesPageStatus.deleteError;

  bool get isIssueLoading => this == LegalIssuesPageStatus.issueLoading;

  bool get isIssueSuccess => this == LegalIssuesPageStatus.issueSuccess;

  bool get isIssueError => this == LegalIssuesPageStatus.issueError;

  bool get isDownloading => this == LegalIssuesPageStatus.downloading;

  bool get isDownloaded => this == LegalIssuesPageStatus.downloaded;

  bool get isDownloadError => this == LegalIssuesPageStatus.downloadError;
}

@immutable
class LegalIssuesPageState extends Equatable {
  final List<LegalIssue>? issues;
  final LegalIssuesPageStatus status;
  final LegalIssue? issue;

  const LegalIssuesPageState({
    this.issues,
    this.status = LegalIssuesPageStatus.initial,
    this.issue,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        issues,
        status,
        issue,
      ];

  LegalIssuesPageState copyWith({
    List<LegalIssue>? issues,
    LegalIssuesPageStatus? status,
    LegalIssue? issue,
    bool? isLegalIssueLoading,
    String? message,
  }) {
    return LegalIssuesPageState(
      issues: issues ?? this.issues,
      status: status ?? this.status,
      issue: issue ?? this.issue,
    );
  }
}
