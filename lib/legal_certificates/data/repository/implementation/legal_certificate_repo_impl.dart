import '../../model/legal_certificate.dart';
import '../definition/legal_certificate_repo.dart';

class LegalCertificateRepoImpl extends LegalCertificateRepo {
  @override
  Future<List<LegalCertificate>> getAllLegalCertificates(String authToken) async {
    // TODO: implement getAllLegalCertificates
    // throw UnimplementedError();
    List<LegalCertificate> getLegalCertificates() {
      return [
        LegalCertificate('DA-001', 'Admin', 'Demo Certificate 2',
            'Dirm Attorneys Certificate.pdf', 'Pending'),
        LegalCertificate('DA-002', 'Admin', 'Demo Legal Certificate',
            'Dirm Attorneys Certificate.pdf', 'Pending'),
        LegalCertificate('DA-003', 'Admin', 'Demo Legal Certificate',
            'Dirm Attorneys Certificate.pdf', 'Pending'),
        LegalCertificate('DA-004', 'Admin', 'Demo Legal Certificate',
            'Dirm Attorneys Certificate.pdf', 'Pending'),
        LegalCertificate('DA-005', 'Admin', 'Demo Legal Certificate',
            'Dirm Attorneys Certificate.pdf', 'Pending'),
      ];
    }

    return getLegalCertificates();
  }
}
