part of 'appointments_page_bloc.dart';

enum AppointmentsPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
}

extension AppointmentsPageStatusX on AppointmentsPageStatus {
  bool get isInitial => this == AppointmentsPageStatus.initial;

  bool get isSuccess => this == AppointmentsPageStatus.success;

  bool get isLoading => this == AppointmentsPageStatus.loading;

  bool get isError => this == AppointmentsPageStatus.error;

  bool get isNotFound => this == AppointmentsPageStatus.notFound;

  bool get isEmpty => this == AppointmentsPageStatus.empty;
}

@immutable
class AppointmentsPageState extends Equatable {
  final List<Appointment>? appointments;
  final AppointmentsPageStatus status;
  final Appointment? appointment;

  const AppointmentsPageState({
    this.appointments,
    this.status = AppointmentsPageStatus.initial,
    this.appointment,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    appointments,
    status,
    appointment,
  ];

  AppointmentsPageState copyWith({
    List<Appointment>? appointments,
    AppointmentsPageStatus? status,
    Appointment? appointment,
    bool? isAppointmentLoading,
    String? message,
  }) {
    return AppointmentsPageState(
      appointments: appointments ?? this.appointments,
      status: status ?? this.status,
      appointment: appointment ?? this.appointment,
    );
  }
}