import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;

import '../../../Global/Variables/strings.dart';

class LegalIssueRequests {
  static Future<dynamic> getLegalIssues(String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(APP_DNS, '/api/v1/get_legal_issues');

    var response = await client.get(url.toString());
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.data)) as Map;
      return jsonResponse["data"];
    } else {
      throw Error();
      // throw Exception("An error occurred");
    }
  }

  static Future<dynamic> postLegalIssue(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(APP_DNS, '/api/v1/add_legal_issue');

    var response = await client.post(url.toString(), data: body);
    if (response.statusCode == 201) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.data)) as Map;
      return jsonResponse;
    } else {
      throw Error();
      // throw Exception("An error occurred");
    }
  }
}
