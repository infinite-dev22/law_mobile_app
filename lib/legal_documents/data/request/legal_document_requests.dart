import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:dirm_attorneys_mobile/legal_documents/data/model/legal_document.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;

import '../../../Global/Variables/strings.dart';
import '../../../Global/data/model/global_response_model.dart';

class LegalDocumentRequests {
  static Future<List<LegalDocument>> getLegalDocuments(String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_legal_documents');

    List<LegalDocument> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
      (value) {
        List response = value.data["data"];
        responseModel =
            response.map((doc) => LegalDocument.fromJson(doc)).toList();
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postLegalDocument(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/add_legal_document');

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

  static Future<GlobalResponseModel?> deleteLegalDocument(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/delete_legal_documents/$slug');

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

  static Future<LegalDocument?> getLegalDocument(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_legal_documents/$slug');

    LegalDocument? responseModel;
    await client.get(url.toString()).then(
          (value) {
        if (value.statusCode == 200) {
          responseModel = LegalDocument.fromJson(value.data["data"]["data"]);
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

  static Future<GlobalResponseModel?> downloadLegalDocument(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/download_uploaded_doc/slug');

    GlobalResponseModel? responseModel;
    await client.download(url.toString(), "~/Documents").then(
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
}
