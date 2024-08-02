part of 'legal_documents_page_bloc.dart';

sealed class LegalDocumentsPageEvent extends Equatable {
  const LegalDocumentsPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadLegalDocumentsEvent extends LegalDocumentsPageEvent {}

class RefreshLegalDocumentsEvent extends LegalDocumentsPageEvent {}

class LoadSingleLegalDocumentEvent extends LegalDocumentsPageEvent {
  final int id;

  const LoadSingleLegalDocumentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LegalDocumentPostEvent extends LegalDocumentsPageEvent {
  final LegalDocument legalDocument;

  const LegalDocumentPostEvent(this.legalDocument);

  @override
  List<Object?> get props => [legalDocument];
}

class LegalDocumentAddedEvent extends LegalDocumentsPageEvent {}
