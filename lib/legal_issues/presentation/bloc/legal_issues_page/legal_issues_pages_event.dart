part of 'legal_issues_pages_bloc.dart';

sealed class LegalIssuesPageEvent extends Equatable {
  const LegalIssuesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadLegalIssuesEvent extends LegalIssuesPageEvent {}

class RefreshLegalIssuesEvent extends LegalIssuesPageEvent {}

class LoadSingleLegalIssueEvent extends LegalIssuesPageEvent {
  final int id;

  const LoadSingleLegalIssueEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LegalIssuePostEvent extends LegalIssuesPageEvent {
  final LegalIssue legalIssue;

  const LegalIssuePostEvent(this.legalIssue);

  @override
  List<Object?> get props => [legalIssue];
}

class LegalIssueAddedEvent extends LegalIssuesPageEvent {}

class DeleteLegalIssueEvent extends LegalIssuesPageEvent {
  final String slug;

  const DeleteLegalIssueEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class GetLegalIssueEvent extends LegalIssuesPageEvent {
  final String slug;

  const GetLegalIssueEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class DownloadLegalIssueEvent extends LegalIssuesPageEvent {
  final String slug;

  const DownloadLegalIssueEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}
