import '../../model/legal_certificate.dart';

abstract class LegalCertificateRepo {
  Future<List<LegalCertificate>> getAllLegalCertificates(String authToken);

  dynamic postLegalCertificate(String authToken, LegalCertificate data);
}
