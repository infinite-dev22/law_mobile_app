import 'package:dio/dio.dart';
import 'package:dirm_attorneys_mobile/legal_issues/data/model/legal_issue.dart';

import '../../request/legal_issue_requests.dart';
import '../definition/legal_issue_repo.dart';

class LegalIssueRepoImpl extends LegalIssueRepo {
  @override
  Future<List<LegalIssue>> getAllLegalIssues(String authToken) async {
    List<LegalIssue> legalIssues = List.empty(growable: true);
    LegalIssueRequests.getLegalIssues(authToken)
        .then((value) => legalIssues = value);
    return legalIssues;
  }

  @override
  Future<dynamic> postLegalIssue(String authToken, LegalIssue data) async {
    var legalIssues = List.empty(growable: true);

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    LegalIssueRequests.postLegalIssue(authToken, formData)
        .then((value) => legalIssues = value);
    return legalIssues;
  }
}
