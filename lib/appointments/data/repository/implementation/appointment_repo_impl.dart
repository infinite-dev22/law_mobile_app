import '../../model/appointment.dart';
import '../definition/appointment_repo.dart';

class AppointmentRepoImpl extends AppointmentRepo {
  @override
  Future<List<Appointment>> getAllAppointments(String authToken) async {
    // TODO: implement getAllAppointments
    // throw UnimplementedError();
    List<Appointment> getAppointments() {
      return [
        Appointment('DA-001', 'Admin', 'Demo Appointment 2',
            'Dirm Attorneys Appointment.pdf', 'Pending'),
        Appointment('DA-002', 'Admin', 'Demo Legal Appointment',
            'Dirm Attorneys Appointment.pdf', 'Pending'),
        Appointment('DA-003', 'Admin', 'Demo Legal Appointment',
            'Dirm Attorneys Appointment.pdf', 'Pending'),
        Appointment('DA-004', 'Admin', 'Demo Legal Appointment',
            'Dirm Attorneys Appointment.pdf', 'Pending'),
        Appointment('DA-005', 'Admin', 'Demo Legal Appointment',
            'Dirm Attorneys Appointment.pdf', 'Pending'),
      ];
    }

    return getAppointments();
  }
}
