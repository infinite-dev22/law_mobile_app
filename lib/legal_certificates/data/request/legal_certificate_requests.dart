import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:dirm_attorneys_mobile/legal_certificates/data/model/legal_certificate.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;
import 'package:path_provider/path_provider.dart';

import '../../../Global/Variables/strings.dart';
import '../../../Global/data/model/global_response_model.dart';

class LegalCertificateRequests {
  static Future<List<LegalCertificate>> getLegalCertificates(
      String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_legal_issues');

    List<LegalCertificate> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
      (value) {
        List response = value.data["data"];
        responseModel =
            response.map((doc) => LegalCertificate.fromJson(doc)).toList();
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postLegalCertificate(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/add_certify_document');

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

  static Future<GlobalResponseModel?> putLegalCertificate(
      String authToken, http.FormData body, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/update_certify_document/$slug');

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
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> deleteLegalCertificate(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/delete_certify_documents/$slug');

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

  static Future<LegalCertificate?> getLegalCertificate(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_certify_documents/$slug');

    LegalCertificate? responseModel;
    await client.get(url.toString()).then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = LegalCertificate.fromJson(value.data["data"]["data"]);
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

  static Future<GlobalResponseModel?> downloadLegalCertificate(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/download_certify_reply_doc/$slug');

    String path = await _getFilePath("$slug.pdf");

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
