part of 'appointments_page_bloc.dart';

sealed class AppointmentsPageEvent extends Equatable {
  const AppointmentsPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointmentsEvent extends AppointmentsPageEvent {}

class RefreshAppointmentsEvent extends AppointmentsPageEvent {}

class LoadSingleAppointmentEvent extends AppointmentsPageEvent {
  final int id;

  const LoadSingleAppointmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AppointmentAddedEvent extends AppointmentsPageEvent {}
