import '../../model/legal_certificate.dart';
import '../../request/legal_certificate_requests.dart';
import '../definition/legal_certificate_repo.dart';

class LegalCertificateRepoImpl extends LegalCertificateRepo {
  @override
  Future<List<LegalCertificate>> getAllLegalCertificates(
      String authToken) async {
    List<LegalCertificate> legalCertificates = List.empty(growable: true);
    LegalCertificateRequests.getLegalCertificates(authToken)
        .then((value) => legalCertificates = value);
    return legalCertificates;
  }

  @override
  dynamic postLegalCertificate(String authToken, LegalCertificate data) async {
    var legalCertificates = List.empty(growable: true);
    LegalCertificateRequests.postLegalCertificate(authToken, data.postJson())
        .then((value) => legalCertificates = value);
    return legalCertificates;
  }
}
