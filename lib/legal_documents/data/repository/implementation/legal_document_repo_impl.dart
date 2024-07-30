import '../../model/legal_document.dart';
import '../definition/legal_document_repo.dart';

class LegalDocumentRepoImpl extends LegalDocumentRepo {
  @override
  Future<List<LegalDocument>> getAllLegalDocuments(String authToken) async {
    // TODO: implement getAllLegalDocuments
    // throw UnimplementedError();
    List<LegalDocument> getLegalDocuments() {
      return [
        LegalDocument('DA-001', 'Admin', 'Demo Document 2',
            'Dirm Attorneys Requirements.pdf', 'Pending'),
        LegalDocument('DA-002', 'Admin', 'Demo Legal Document',
            'Dirm Attorneys Requirements.pdf', 'Pending'),
        LegalDocument('DA-003', 'Admin', 'Demo Legal Document',
            'Dirm Attorneys Requirements.pdf', 'Pending'),
        LegalDocument('DA-004', 'Admin', 'Demo Legal Document',
            'Dirm Attorneys Requirements.pdf', 'Pending'),
        LegalDocument('DA-005', 'Admin', 'Demo Legal Document',
            'Dirm Attorneys Requirements.pdf', 'Pending'),
      ];
    }

    return getLegalDocuments();
  }
}
