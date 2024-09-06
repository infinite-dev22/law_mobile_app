import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.title,
    required this.slug,
    required this.clientId,
    required this.attorneyId,
    required this.availabilityId,
    required this.venue,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.comment,
    required this.status,
    required this.attorney,
    required this.statusText,
  });

  final int? id;
  final String? title;
  final String? slug;
  final int? clientId;
  final int? attorneyId;
  final int? availabilityId;
  final String? venue;
  final String? appointmentDate;
  final String? appointmentTime;
  final String? appointmentEndTime;
  final String? comment;
  final String? status;
  final String? attorney;
  final String? statusText;

  Appointment copyWith({
    int? id,
    String? title,
    String? slug,
    int? clientId,
    int? attorneyId,
    int? availabilityId,
    String? venue,
    String? appointmentDate,
    String? appointmentTime,
    String? appointmentEndTime,
    String? comment,
    String? status,
    String? attorney,
    String? statusText,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      clientId: clientId ?? this.clientId,
      attorneyId: attorneyId ?? this.attorneyId,
      availabilityId: availabilityId ?? this.availabilityId,
      venue: venue ?? this.venue,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentEndTime: appointmentEndTime ?? this.appointmentEndTime,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      attorney: attorney ?? this.attorney,
      statusText: statusText ?? this.statusText,
    );
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      clientId: json["client_id"],
      attorneyId: json["attorney_id"],
      availabilityId: json["availability_id"],
      venue: json["venue"],
      appointmentDate: json["appointment_date"],
      appointmentTime: json["appointment_time"],
      appointmentEndTime: json["appointment_end_time"],
      comment: json["comment"],
      status: json["status"],
      attorney: json["attorney"],
      statusText: json["status_text"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "client_id": clientId,
        "attorney_id": attorneyId,
        "availability_id": availabilityId,
        "venue": venue,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "appointment_end_time": appointmentEndTime,
        "comment": comment,
        "status": status,
        "attorney": attorney,
        "status_text": statusText,
      };

  const Appointment.post({
    required this.title,
    required this.availabilityId,
    required this.attorneyId,
    required this.venue,
    required this.comment,
    required this.appointmentTime,
    required this.appointmentEndTime,
    this.id,
    this.slug,
    this.clientId,
    this.appointmentDate,
    this.status,
    this.attorney,
    this.statusText,
  });

  @override
  String toString() {
    return "$id, $title, $slug, $clientId, $attorneyId, $availabilityId, $venue, $appointmentDate, $appointmentTime, $appointmentEndTime, $comment, $status,  $attorney, $statusText, ";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        clientId,
        attorneyId,
        availabilityId,
        venue,
        appointmentDate,
        appointmentTime,
        appointmentEndTime,
        comment,
        status,
        attorney,
        statusText,
      ];
}
