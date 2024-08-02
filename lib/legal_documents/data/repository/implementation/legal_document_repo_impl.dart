import '../../model/legal_document.dart';
import '../../request/legal_document_requests.dart';
import '../definition/legal_document_repo.dart';

class LegalDocumentRepoImpl extends LegalDocumentRepo {
  @override
  Future<List<LegalDocument>> getAllLegalDocuments(String authToken) async {
    List<LegalDocument> legalDocuments = List.empty(growable: true);
    LegalDocumentRequests.getLegalDocuments(authToken)
        .then((value) => legalDocuments = value);
    return legalDocuments;
  }

  @override
  dynamic postLegalDocument(String authToken, LegalDocument data) async {
    var legalDocuments = List.empty(growable: true);
    LegalDocumentRequests.postLegalDocument(authToken, data.postJson())
        .then((value) => legalDocuments = value);
    return legalDocuments;
  }
}
