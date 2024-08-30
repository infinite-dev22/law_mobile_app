import '../../model/appointment.dart';
import '../../model/attorney_availability.dart';

abstract class AppointmentRepo {
  Future<List<Appointment>> getAllAppointments(String authToken);

  dynamic postAppointment(String authToken, Appointment data);

  dynamic putAppointment(String authToken, Appointment data);

  dynamic deleteAppointment(String authToken, String slug);
  dynamic cancelAppointment(String authToken, String slug);

  Future<Appointment?> getAppointment(String authToken, String slug);
  Future<List<AttorneyAvailability>> getAttorneyAvailability(String authToken, int attorneyId);
}
