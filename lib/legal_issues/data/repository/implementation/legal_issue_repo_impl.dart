import 'package:dirm_attorneys_mobile/legal_issues/data/model/legal_issue.dart';

import '../definition/legal_issue_repo.dart';

class LegalIssueRepoImpl extends LegalIssueRepo {
  @override
  Future<List<LegalIssue>> getAllLegalIssues(String authToken) async {
    // TODO: implement getAllLegalIssues
    // throw UnimplementedError();
    List<LegalIssue> getLegalIssues() {
      return [
        LegalIssue('DA-001', 'Admin', 'Demo Issue 2',
            'Dirm Attorneys Issue.pdf', 'Pending'),
        LegalIssue('DA-002', 'Admin', 'Demo Legal Issue',
            'Dirm Attorneys Issue.pdf', 'Pending'),
        LegalIssue('DA-003', 'Admin', 'Demo Legal Issue',
            'Dirm Attorneys Issue.pdf', 'Pending'),
        LegalIssue('DA-004', 'Admin', 'Demo Legal Issue',
            'Dirm Attorneys Issue.pdf', 'Pending'),
        LegalIssue('DA-005', 'Admin', 'Demo Legal Issue',
            'Dirm Attorneys Issue.pdf', 'Pending'),
      ];
    }

    return getLegalIssues();
  }
}
