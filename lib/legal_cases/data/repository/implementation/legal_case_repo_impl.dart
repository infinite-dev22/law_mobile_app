import '../../model/legal_case.dart';
import '../definition/legal_case_repo.dart';

class LegalCaseRepoImpl extends LegalCaseRepo {
  @override
  Future<List<LegalCase>> getAllLegalCases(String authToken) async {
    // TODO: implement getAllLegalCases
    // throw UnimplementedError();
    List<LegalCase> getLegalCases() {
      return [
        LegalCase('DA-001', 'Admin', 'Demo Case 2',
            'Dirm Attorneys Case.pdf', 'Pending'),
        LegalCase('DA-002', 'Admin', 'Demo Legal Case',
            'Dirm Attorneys Case.pdf', 'Pending'),
        LegalCase('DA-003', 'Admin', 'Demo Legal Case',
            'Dirm Attorneys Case.pdf', 'Pending'),
        LegalCase('DA-004', 'Admin', 'Demo Legal Case',
            'Dirm Attorneys Case.pdf', 'Pending'),
        LegalCase('DA-005', 'Admin', 'Demo Legal Case',
            'Dirm Attorneys Case.pdf', 'Pending'),
      ];
    }

    return getLegalCases();
  }
}
