import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/attorney_availability.dart';

import 'package:dirm_attorneys_mobile/Global/data/model/global_response_model.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/appointment.dart';
import 'package:dirm_attorneys_mobile/appointments/data/request/appointment_requests.dart';
import 'package:dirm_attorneys_mobile/appointments/data/repository/definition/appointment_repo.dart';

class AppointmentRepoImpl extends AppointmentRepo {
  @override
  Future<List<Appointment>> getAllAppointments(String authToken) async {
    List<Appointment> legalCases = List.empty(growable: true);

    await AppointmentRequests.getAppointments(authToken)
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
  Future<GlobalResponseModel?> postAppointment(
      String authToken, Appointment data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "availability_id": data.availabilityId,
      "attorney_id": data.attorneyId,
      "venue": data.venue,
      "comment": data.comment,
      "start_date": data.appointmentDate,
      "end_time": data.appointmentEndTime,
    });

    await AppointmentRequests.postAppointment(authToken, formData)
        .then((value) {
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
  Future<GlobalResponseModel?> putAppointment(
      String authToken, Appointment data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "availability_id": data.availabilityId,
      "attorney_id": data.attorneyId,
      "venue": data.venue,
      "comment": data.comment,
      "start_date": data.appointmentDate,
      "end_time": data.appointmentEndTime,
    });

    await AppointmentRequests.putAppointment(authToken, formData, data.slug!)
        .then((value) {
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
  Future<GlobalResponseModel?> deleteAppointment(
      String authToken, String slug) async {
    late GlobalResponseModel? response;

    await AppointmentRequests.deleteAppointment(authToken, slug).then((value) {
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
  Future<Appointment?> getAppointment(String authToken, String slug) async {
    late Appointment? response;

    await AppointmentRequests.getAppointment(authToken, slug).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) => throw Exception(error),
    );
    return response;
  }

  @override
  cancelAppointment(String authToken, String slug) async {
    late GlobalResponseModel? response;

    await AppointmentRequests.cancelAppointment(authToken, slug).then((value) {
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
  Future<List<AttorneyAvailability>> getAttorneyAvailability(
      String authToken, int attorneyId) async {
    List<AttorneyAvailability> attorneyAvailability =
        List.empty(growable: true);

    await AppointmentRequests.getAttorneyAvailability(authToken, attorneyId)
        .then((value) => attorneyAvailability = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
        );
    return attorneyAvailability;
  }
}
