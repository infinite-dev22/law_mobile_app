part of 'appointments_page_bloc.dart';

enum AppointmentsPageStatus {
  initial,
  success,
  postSuccess,
  loading,
  postLoading,
  error,
  postError,
  notFound,
  empty,
}

extension AppointmentsPageStatusX on AppointmentsPageStatus {
  bool get isInitial => this == AppointmentsPageStatus.initial;

  bool get isSuccess => this == AppointmentsPageStatus.success;

  bool get isPostSuccess => this == AppointmentsPageStatus.postSuccess;

  bool get isLoading => this == AppointmentsPageStatus.loading;

  bool get isPostLoading => this == AppointmentsPageStatus.postLoading;

  bool get isError => this == AppointmentsPageStatus.error;

  bool get isPostError => this == AppointmentsPageStatus.postError;

  bool get isNotFound => this == AppointmentsPageStatus.notFound;

  bool get isEmpty => this == AppointmentsPageStatus.empty;
}

@immutable
class AppointmentsPageState extends Equatable {
  final List<Appointment>? appointments;
  final List<AttorneyAvailability>? attorneyAvailability;
  final AppointmentsPageStatus status;
  final Appointment? appointment;

  const AppointmentsPageState({
    this.appointments,
    this.attorneyAvailability,
    this.status = AppointmentsPageStatus.initial,
    this.appointment,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        appointments,
        attorneyAvailability,
        status,
        appointment,
      ];

  AppointmentsPageState copyWith({
    List<Appointment>? appointments,
    List<AttorneyAvailability>? attorneyAvailability,
    AppointmentsPageStatus? status,
    Appointment? appointment,
    bool? isAppointmentLoading,
    String? message,
  }) {
    return AppointmentsPageState(
      appointments: appointments ?? this.appointments,
      attorneyAvailability: attorneyAvailability ?? this.attorneyAvailability,
      status: status ?? this.status,
      appointment: appointment ?? this.appointment,
    );
  }
}
