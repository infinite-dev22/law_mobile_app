import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';
import 'package:dirm_attorneys_mobile/queries/data/repository/definition/query_repo.dart';
import 'package:dirm_attorneys_mobile/queries/data/request/query_requests.dart';

class QueryRepoImpl extends QueryRepo {
  @override
  Future<List<Query>> getAllQueries(String authToken) async {
    List<Query> legalCases = List.empty(growable: true);

    await QueryRequests.getQuerys(authToken)
        .then((value) => legalCases = value)
        .onError(
      (error, stackTrace) {
        log(stackTrace.toString());
        throw Exception(error);
      },
    );
    return legalCases;
  }

  @override
  Future<GlobalResponseModel?> postQuery(String authToken, Query data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "attachment": data.attachment,
    });

    await QueryRequests.postQuery(authToken, formData).then((value) {
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
  Future<GlobalResponseModel?> putQuery(String authToken, Query data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "attachment": await MultipartFile.fromFile(data.attachment!.path,
          filename: data.attachment!.path.split('/').last),
    });

    await QueryRequests.putQuery(authToken, formData, data.id!).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        log(stackTrace.toString());
        throw Exception(error);
      },
    );
    return response;
  }

  @override
  Future<GlobalResponseModel?> deleteQuery(
      String authToken, int queryId) async {
    late GlobalResponseModel? response;

    await QueryRequests.deleteQuery(authToken, queryId).then((value) {
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
  Future<Query?> getQuery(String authToken, int queryId) async {
    late Query? response;

    await QueryRequests.getQuery(authToken, queryId).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) => throw Exception(error),
    );
    return response;
  }
}
