part of 'legal_certificates_page_bloc.dart';

enum LegalCertificatesPageStatus {
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
  certificateLoading,
  certificateSuccess,
  certificateEdit,
  certificateError,
  downloading,
  downloaded,
  downloadError,
}

extension LegalCertificatesPageStatusX on LegalCertificatesPageStatus {
  bool get isInitial => this == LegalCertificatesPageStatus.initial;

  bool get isSuccess => this == LegalCertificatesPageStatus.success;

  bool get isLoading => this == LegalCertificatesPageStatus.loading;

  bool get isError => this == LegalCertificatesPageStatus.error;

  bool get isNotFound => this == LegalCertificatesPageStatus.notFound;

  bool get isEmpty => this == LegalCertificatesPageStatus.empty;

  bool get isPosting => this == LegalCertificatesPageStatus.posting;

  bool get isPosted => this == LegalCertificatesPageStatus.posted;

  bool get isPostError => this == LegalCertificatesPageStatus.postError;

  bool get isDeleting => this == LegalCertificatesPageStatus.deleting;

  bool get isDeleted => this == LegalCertificatesPageStatus.deleted;

  bool get isDeleteError => this == LegalCertificatesPageStatus.deleteError;

  bool get isCertificateLoading =>
      this == LegalCertificatesPageStatus.certificateLoading;

  bool get isCertificateSuccess =>
      this == LegalCertificatesPageStatus.certificateSuccess;

  bool get isCertificateError =>
      this == LegalCertificatesPageStatus.certificateError;

  bool get isCertificateEdit =>
      this == LegalCertificatesPageStatus.certificateEdit;

  bool get isDownloading => this == LegalCertificatesPageStatus.downloading;

  bool get isDownloaded => this == LegalCertificatesPageStatus.downloaded;

  bool get isDownloadError => this == LegalCertificatesPageStatus.downloadError;
}

@immutable
class LegalCertificatesPageState extends Equatable {
  final List<LegalCertificate>? certificates;
  final LegalCertificatesPageStatus status;
  final LegalCertificate? certificate;

  const LegalCertificatesPageState({
    this.certificates,
    this.status = LegalCertificatesPageStatus.initial,
    this.certificate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        certificates,
        status,
        certificate,
      ];

  LegalCertificatesPageState copyWith({
    List<LegalCertificate>? certificates,
    LegalCertificatesPageStatus? status,
    LegalCertificate? certificate,
    bool? isLegalCertificateLoading,
    String? message,
  }) {
    return LegalCertificatesPageState(
      certificates: certificates ?? this.certificates,
      status: status ?? this.status,
      certificate: certificate ?? this.certificate,
    );
  }
}
