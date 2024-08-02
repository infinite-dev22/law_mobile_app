import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../Global/Variables/strings.dart';

class LegalCertificateRequests {
  static Future<dynamic> getLegalCertificates(String authToken) async {
    final client = RetryClient(http.Client());
    var url = Uri.https(APP_DNS, '/api/v1/get_legal_issues');

    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes)) as Map;
      return jsonResponse["data"];
    } else {
      throw Error();
      // throw Exception("An error occurred");
    }
  }

  static Future<dynamic> postLegalCertificate(
      String authToken, Map<String, dynamic> body) async {
    final client = RetryClient(http.Client());
    var url = Uri.https(APP_DNS, '/api/v1/add_certify_document');

    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await client.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes)) as Map;
      return jsonResponse;
    } else {
      throw Error();
      // throw Exception("An error occurred");
    }
  }
}
