import '../../model/legal_case.dart';
import '../../request/legal_case_requests.dart';
import '../definition/legal_case_repo.dart';

class LegalCaseRepoImpl extends LegalCaseRepo {
  @override
  Future<List<LegalCase>> getAllLegalCases(String authToken) async {
    List<LegalCase> legalCases = List.empty(growable: true);
    LegalCaseRequests.getLegalCases(authToken)
        .then((value) => legalCases = value);
    return legalCases;
  }

  @override
  dynamic postLegalCase(String authToken, LegalCase data) async {
    var legalCases = List.empty(growable: true);
    LegalCaseRequests.postLegalCase(authToken, data.postJson())
        .then((value) => legalCases = value);
    return legalCases;
  }
}
