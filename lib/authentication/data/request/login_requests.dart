import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:dirm_attorneys_mobile/authentication/data/model/login_response_model.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;

import '../../../Global/Variables/app_runtime_values.dart';
import '../../../Global/Variables/strings.dart';
import '../../../Global/data/model/global_response_model.dart';

class LoginRequests {
  static Future<LoginResponseModel?> postLogin(
      Map<String, dynamic> body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/authenicate');

    LoginResponseModel? responseModel;
    await client.post(url.toString(), data: body).then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = LoginResponseModel.fromJson(value.data);
          authData = responseModel!;
        } else {
          throw Exception("An error occurred");
        }
      },
    ).onError(
      (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postSignUp(
      Map<String, dynamic> body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/register_customers');

    GlobalResponseModel? responseModel;
    await client.post(url.toString(), data: body).then(
      (value) {
        if (value.statusCode == 201) {
          responseModel = GlobalResponseModel.fromJson(value.data);
        } else {
          throw Exception("An error occurred");
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
