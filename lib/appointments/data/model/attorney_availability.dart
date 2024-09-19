import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AttorneyAvailability extends Equatable {
  AttorneyAvailability({
    required this.id,
    required this.attorneyId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.available,
    required this.notes,
  });

  final int? id;
  final dynamic attorneyId;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final dynamic available;
  final dynamic notes;

  AttorneyAvailability copyWith({
    int? id,
    dynamic attorneyId,
    DateTime? date,
    String? startTime,
    String? endTime,
    dynamic available,
    dynamic notes,
  }) {
    return AttorneyAvailability(
      id: id ?? this.id,
      attorneyId: attorneyId ?? this.attorneyId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      available: available ?? this.available,
      notes: notes ?? this.notes,
    );
  }

  factory AttorneyAvailability.fromJson(Map<String, dynamic> json) {
    return AttorneyAvailability(
      id: json["id"],
      attorneyId: json["attorney_id"],
      date: DateTime.tryParse(json["date"]),
      startTime: json["start_time"],
      endTime: json["end_time"],
      available: json["available"],
      notes: json["notes"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attorney_id": attorneyId,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "available": available,
        "notes": notes,
      };

  @override
  String toString() {
    return DateFormat("dd/MM/yyyy").format(date!);
  }

  @override
  List<Object?> get props => [
        id,
        attorneyId,
        date,
        startTime,
        endTime,
        available,
        notes,
      ];
}
