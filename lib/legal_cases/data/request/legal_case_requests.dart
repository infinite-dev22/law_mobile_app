import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:dirm_attorneys_mobile/legal_cases/data/model/legal_case.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;
import 'package:path_provider/path_provider.dart';

import '../../../Global/Variables/strings.dart';
import '../../../Global/data/model/global_response_model.dart';

class LegalCaseRequests {
  static Future<List<LegalCase>> getLegalCases(String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_legal_cases');

    List<LegalCase> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
      (value) {
        List response = value.data["data"];
        responseModel = response.map((doc) => LegalCase.fromJson(doc)).toList();
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postLegalCase(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/add_legal_case');

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

  static Future<GlobalResponseModel?> putLegalCase(
      String authToken, http.FormData body, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/update_legal_cases/$slug');

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

  static Future<GlobalResponseModel?> deleteLegalCase(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/delete_legal_cases/$slug');

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

  static Future<LegalCase?> getLegalCase(String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_legal_cases/$slug');

    LegalCase? responseModel;
    await client.get(url.toString()).then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = LegalCase.fromJson(value.data["data"]["data"]);
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

  static Future<GlobalResponseModel?> downloadLegalCase(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    String path = await _getFilePath("$slug.pdf");

    var url = Uri.https(appDNS, '/api/v1/download_cases_reply_doc/$slug');

    GlobalResponseModel? responseModel;
    await client
        .download(
      url.toString(),
      path,
      deleteOnError: true,
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = GlobalResponseModel.fromJson(const {
            "status": true,
            "message": "An error occurred whilst adding an issue.",
            "data": 0
          });
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

  static Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}
