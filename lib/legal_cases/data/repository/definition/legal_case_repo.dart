import '../../model/legal_case.dart';

abstract class LegalCaseRepo {
  Future<List<LegalCase>> getAllLegalCases(String authToken);

  dynamic postLegalCase(String authToken, LegalCase data);

  dynamic deleteLegalCase(String authToken, String slug);

  Future<LegalCase?> getLegalCase(String authToken, String slug);

  dynamic downloadLegalCase(String authToken, String slug);
}
