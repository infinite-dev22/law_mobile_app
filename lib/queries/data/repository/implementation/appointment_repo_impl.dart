import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';
import 'package:dirm_attorneys_mobile/queries/data/request/query_requests.dart';
import 'package:dirm_attorneys_mobile/queries/data/repository/definition/appointment_repo.dart';

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
      "client_id": data.clientId,
      "expert_id": data.expertId,
      "status": data.status,
      "priority": data.priority,
      "attachment": data.attachment,
      "solution": data.solution,
      "rating": data.rating,
      "comment": data.comment,
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
      "client_id": data.clientId,
      "expert_id": data.expertId,
      "status": data.status,
      "priority": data.priority,
      "attachment": data.attachment,
      "solution": data.solution,
      "rating": data.rating,
      "comment": data.comment,
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
