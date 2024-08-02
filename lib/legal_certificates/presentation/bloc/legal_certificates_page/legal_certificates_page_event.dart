part of 'legal_certificates_page_bloc.dart';

sealed class LegalCertificatesPageEvent extends Equatable {
  const LegalCertificatesPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadLegalCertificatesEvent extends LegalCertificatesPageEvent {}

class RefreshLegalCertificatesEvent extends LegalCertificatesPageEvent {}

class LoadSingleLegalCertificateEvent extends LegalCertificatesPageEvent {
  final int id;

  const LoadSingleLegalCertificateEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LegalCertificatePostEvent extends LegalCertificatesPageEvent {
  final LegalCertificate legalCertificate;

  const LegalCertificatePostEvent(this.legalCertificate);

  @override
  List<Object?> get props => [legalCertificate];
}

class LegalCertificateAddedEvent extends LegalCertificatesPageEvent {}
