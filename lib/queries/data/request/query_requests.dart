import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;

import 'package:dirm_attorneys_mobile/Global/Variables/strings.dart';
import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';

class QueryRequests {
  static Future<List<Query>> getQuerys(String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/client_queries');

    List<Query> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
      (value) {
        List response = value.data["data"];
        responseModel = response.map((doc) => Query.fromJson(doc)).toList();
      },
    ).onError(
      (error, stackTrace) {
        log(stackTrace.toString());
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postQuery(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/client_queries');

    GlobalResponseModel? responseModel;
    await client.post(url.toString(), data: body).then(
      (value) {
        if (value.statusCode == 201) {
          GlobalResponseModel.fromJson(value.data);
        } else {
          throw Exception("An error occurred!");
        }
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> putQuery(
      String authToken, http.FormData body, int queryId) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/client_queries/$queryId');

    GlobalResponseModel? responseModel;
    await client.post(url.toString(), data: body).then(
      (value) {
        if (value.statusCode == 200) {
          GlobalResponseModel.fromJson(value.data);
        } else {
          throw Exception("An error occurred!");
        }
      },
    ).onError(
      (error, stackTrace) {
        log("An error occurred", stackTrace: stackTrace);
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> deleteQuery(
      String authToken, int queryId) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/client_queries/$queryId');

    GlobalResponseModel? responseModel;
    await client.delete(url.toString()).then(
      (value) {
        if (value.statusCode == 201) {
          GlobalResponseModel.fromJson(value.data);
        } else {
          throw Exception("An error occurred!");
        }
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<Query?> getQuery(String authToken, int queryId) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/client_queries/$queryId');

    Query? responseModel;
    await client.get(url.toString()).then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = Query.fromJson(value.data["data"]["data"]);
        } else {
          throw Exception("An error occurred!");
        }
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }
}
