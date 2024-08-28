import '../../model/legal_certificate.dart';

abstract class LegalCertificateRepo {
  Future<List<LegalCertificate>> getAllLegalCertificates(String authToken);

  dynamic postLegalCertificate(String authToken, LegalCertificate data);
  dynamic putLegalCertificate(String authToken, LegalCertificate data);

  dynamic deleteLegalCertificate(String authToken, String slug);

  Future<LegalCertificate?> getLegalCertificate(String authToken, String slug);

  dynamic downloadLegalCertificate(String authToken, String slug);
}
