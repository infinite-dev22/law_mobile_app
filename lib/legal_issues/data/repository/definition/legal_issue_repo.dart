import '../../model/legal_issue.dart';

abstract class LegalIssueRepo {
  Future<List<LegalIssue>> getAllLegalIssues(String authToken);

  dynamic postLegalIssue(String authToken, LegalIssue data);

  dynamic deleteLegalIssue(String authToken, String slug);

  dynamic downloadLegalIssue(String authToken, String slug);
}
