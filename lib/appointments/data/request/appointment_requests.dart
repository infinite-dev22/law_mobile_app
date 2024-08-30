import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:dirm_attorneys_mobile/appointments/data/model/attorney_availability.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart' as nda;

import 'package:dirm_attorneys_mobile/Global/Variables/strings.dart';
import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/appointment.dart';

class AppointmentRequests {
  static Future<List<Appointment>> getAppointments(String authToken) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_appointments');

    List<Appointment> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
      (value) {
        log(value.data);
        List response = value.data["data"];
        responseModel =
            response.map((doc) => Appointment.fromJson(doc)).toList();
      },
    ).onError(
      (error, stackTrace) {
        log(stackTrace.toString());
        throw Exception(error);
      },
    );
    return responseModel;
  }

  static Future<GlobalResponseModel?> postAppointment(
      String authToken, http.FormData body) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/book_appointment');

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

  static Future<GlobalResponseModel?> putAppointment(
      String authToken, http.FormData body, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/update_appointment/$slug');

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

  static Future<GlobalResponseModel?> deleteAppointment(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/delete_appointments/$slug');

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

  static Future<GlobalResponseModel?> cancelAppointment(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/cancel_appointments/$slug');

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

  static Future<Appointment?> getAppointment(
      String authToken, String slug) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url = Uri.https(appDNS, '/api/v1/get_appointments/$slug');

    Appointment? responseModel;
    await client.get(url.toString()).then(
      (value) {
        if (value.statusCode == 200) {
          responseModel = Appointment.fromJson(value.data["data"]["data"]);
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

  static Future<List<AttorneyAvailability>> getAttorneyAvailability(
      String authToken, int attorneyId) async {
    final client = http.Dio();
    client.httpClientAdapter = nda.NativeAdapter();
    client.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var url =
        Uri.https(appDNS, '/api/v1/get_attorney/$attorneyId/availability');

    List<AttorneyAvailability> responseModel = List.empty(growable: true);
    await client.get(url.toString()).then(
          (value) {
        List response = value.data["data"];
        responseModel =
            response.map((doc) => AttorneyAvailability.fromJson(doc)).toList();
      },
    ).onError(
          (error, stackTrace) {
        throw Exception(error);
      },
    );
    return responseModel;
  }
}
