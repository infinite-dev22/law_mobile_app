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

class LegalCaseAddedEvent extends LegalCasesPageEvent {}
