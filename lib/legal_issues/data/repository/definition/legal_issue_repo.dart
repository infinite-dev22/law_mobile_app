import '../../model/legal_issue.dart';

abstract class LegalIssueRepo {
  Future<List<LegalIssue>> getAllLegalIssues(String authToken);

  dynamic postLegalIssue(String authToken, LegalIssue data);

  dynamic putLegalIssue(String authToken, LegalIssue data);

  dynamic deleteLegalIssue(String authToken, String slug);

  Future<LegalIssue?> getLegalIssue(String authToken, String slug);

  dynamic downloadLegalIssueProcessedDocument(String authToken, String slug);

  dynamic downloadLegalIssueUploadedDocument(String authToken, String slug);
}
