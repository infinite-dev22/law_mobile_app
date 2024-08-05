import '../../model/legal_document.dart';

abstract class LegalDocumentRepo {
  Future<List<LegalDocument>> getAllLegalDocuments(String authToken);

  dynamic postLegalDocument(String authToken, LegalDocument data);
}
