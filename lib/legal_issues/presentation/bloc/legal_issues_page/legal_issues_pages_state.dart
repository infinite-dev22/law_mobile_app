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
