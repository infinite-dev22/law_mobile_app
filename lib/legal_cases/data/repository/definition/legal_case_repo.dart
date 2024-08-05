import '../../model/legal_case.dart';

abstract class LegalCaseRepo {
  Future<List<LegalCase>> getAllLegalCases(String authToken);

  dynamic postLegalCase(String authToken, LegalCase data);
}
