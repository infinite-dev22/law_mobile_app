import '../../model/legal_document.dart';

abstract class LegalDocumentRepo {
  Future<List<LegalDocument>> getAllLegalDocuments(String authToken);

  dynamic postLegalDocument(String authToken, LegalDocument data);

  dynamic deleteLegalDocument(String authToken, String slug);

  Future<LegalDocument?> getLegalDocument(String authToken, String slug);

  dynamic downloadLegalDocument(String authToken, String slug);
}
