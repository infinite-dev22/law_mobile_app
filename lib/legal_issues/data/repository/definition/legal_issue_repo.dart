import '../../model/legal_issue.dart';

abstract class LegalIssueRepo {
  Future<List<LegalIssue>> getAllLegalIssues(String authToken);
}
