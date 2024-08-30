import 'package:dio/dio.dart';
import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/legal_issues/data/model/legal_issue.dart';

import '../../request/legal_issue_requests.dart';
import '../definition/legal_issue_repo.dart';

class LegalIssueRepoImpl extends LegalIssueRepo {
  @override
  Future<List<LegalIssue>> getAllLegalIssues(String authToken) async {
    List<LegalIssue> legalIssues = List.empty(growable: true);
    await LegalIssueRequests.getLegalIssues(authToken)
        .then((value) => legalIssues = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
        );
    return legalIssues;
  }

  @override
  Future<GlobalResponseModel?> postLegalIssue(
      String authToken, LegalIssue data) async {
    late GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await LegalIssueRequests.postLegalIssue(authToken, formData).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> putLegalIssue(
      String authToken, LegalIssue data) async {
    late GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await LegalIssueRequests.putLegalIssue(authToken, formData, data.slug!).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> deleteLegalIssue(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await LegalIssueRequests.deleteLegalIssue(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }

  @override
  Future<LegalIssue?> getLegalIssue(String authToken, String slug) async {
    late LegalIssue? response;

    await LegalIssueRequests.getLegalIssue(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) => throw Exception(error),
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> downloadLegalIssue(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await LegalIssueRequests.downloadLegalIssue(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }
}
