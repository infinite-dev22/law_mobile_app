import '../../model/appointment.dart';

abstract class AppointmentRepo {
  Future<List<Appointment>> getAllAppointments(String authToken);
}
