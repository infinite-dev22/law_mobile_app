part of 'legal_cases_page_bloc.dart';

sealed class LegalCasesPageEvent extends Equatable {
  const LegalCasesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadLegalCasesEvent extends LegalCasesPageEvent {}

class RefreshLegalCasesEvent extends LegalCasesPageEvent {}

class LoadSingleLegalCaseEvent extends LegalCasesPageEvent {
  final int id;

  const LoadSingleLegalCaseEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LegalCasePostEvent extends LegalCasesPageEvent {
  final LegalCase legalCase;

  const LegalCasePostEvent(this.legalCase);

  @override
  List<Object?> get props => [legalCase];
}

class LegalCasePutEvent extends LegalCasesPageEvent {
  final LegalCase legalCase;

  const LegalCasePutEvent(this.legalCase);

  @override
  List<Object?> get props => [legalCase];
}

class LegalCaseAddedEvent extends LegalCasesPageEvent {}

class DeleteLegalCaseEvent extends LegalCasesPageEvent {
  final String slug;

  const DeleteLegalCaseEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class GetLegalCaseEvent extends LegalCasesPageEvent {
  final String slug;
  final bool edit;

  const GetLegalCaseEvent(this.slug, this.edit);

  @override
  List<Object?> get props => [slug, edit];
}

class DownloadLegalCaseEvent extends LegalCasesPageEvent {
  final String slug;

  const DownloadLegalCaseEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}
