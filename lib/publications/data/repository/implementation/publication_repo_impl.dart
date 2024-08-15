import 'package:dio/dio.dart';
import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';

import '../../model/publication.dart';
import '../../request/publication_requests.dart';
import '../definition/publication_repo.dart';

class PublicationRepoImpl extends PublicationRepo {
  @override
  Future<List<Publication>> getAllPublications(String authToken) async {
    List<Publication> legalIssues = List.empty(growable: true);
    await PublicationRequests.getPublications(authToken)
        .then((value) => legalIssues = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
        );
    return legalIssues;
  }

  @override
  Future<GlobalResponseModel?> postPublication(
      String authToken, Publication data) async {
    late GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await PublicationRequests.postPublication(authToken, formData)
        .then((value) {
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
  Future<GlobalResponseModel?> deletePublication(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await PublicationRequests.deletePublication(authToken, slug).then((value) {
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
  Future<Publication?> getPublication(String authToken, String slug) async {
    late Publication? response;

    await PublicationRequests.getPublication(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) => throw Exception(error),
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> downloadPublication(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await PublicationRequests.downloadPublication(authToken, slug)
        .then((value) {
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
