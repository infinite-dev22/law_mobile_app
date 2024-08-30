part of 'appointments_page_bloc.dart';

sealed class AppointmentsPageEvent extends Equatable {
  const AppointmentsPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointmentsEvent extends AppointmentsPageEvent {}

class LoadAttorneyAvailabilityEvent extends AppointmentsPageEvent {
  final int id;

  const LoadAttorneyAvailabilityEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddAppointmentEvent extends AppointmentsPageEvent {
  final Appointment appointment;

  const AddAppointmentEvent(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class UpdateAppointmentEvent extends AppointmentsPageEvent {
  final Appointment appointment;

  const UpdateAppointmentEvent(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class LoadSingleAppointmentEvent extends AppointmentsPageEvent {
  final String slug;

  const LoadSingleAppointmentEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class DeleteAppointmentEvent extends AppointmentsPageEvent {
  final String slug;

  const DeleteAppointmentEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class CancelAppointmentEvent extends AppointmentsPageEvent {
  final String slug;

  const CancelAppointmentEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class AppointmentAddedEvent extends AppointmentsPageEvent {}
