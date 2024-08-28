import 'package:dio/dio.dart';

import '../../../../Global/data/model/global_response_model.dart';
import '../../model/legal_case.dart';
import '../../request/legal_case_requests.dart';
import '../definition/legal_case_repo.dart';

class LegalCaseRepoImpl extends LegalCaseRepo {
  @override
  Future<List<LegalCase>> getAllLegalCases(String authToken) async {
    List<LegalCase> legalCases = List.empty(growable: true);

    await LegalCaseRequests.getLegalCases(authToken)
        .then((value) => legalCases = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
        );
    return legalCases;
  }

  @override
  Future<GlobalResponseModel?> postLegalCase(
      String authToken, LegalCase data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await LegalCaseRequests.postLegalCase(authToken, formData).then((value) {
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
  Future<GlobalResponseModel?> putLegalCase(
      String authToken, LegalCase data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await LegalCaseRequests.putLegalCase(authToken, formData, data.slug!).then((value) {
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
  Future<GlobalResponseModel?> deleteLegalCase(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await LegalCaseRequests.deleteLegalCase(authToken, slug).then((value) {
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
  Future<LegalCase?> getLegalCase(String authToken, String slug) async {
    late LegalCase? response;

    await LegalCaseRequests.getLegalCase(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) => throw Exception(error),
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> downloadLegalCase(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await LegalCaseRequests.downloadLegalCase(authToken, slug).then((value) {
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
