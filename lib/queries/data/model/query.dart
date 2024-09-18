import 'dart:io';

import 'package:equatable/equatable.dart';

class Query extends Equatable {
  Query({
    required this.id,
    required this.title,
    required this.description,
    required this.clientId,
    required this.expertId,
    required this.status,
    required this.priority,
    required this.attachment,
    required this.solution,
    required this.rating,
    required this.comment,
  });

  final int? id;
  final String? title;
  final String? description;
  final int? clientId;
  final dynamic expertId;
  final String? status;
  final String? priority;
  final File? attachment;
  final dynamic solution;
  final dynamic rating;
  final dynamic comment;

  const Query.post({
    this.id,
    required this.title,
    required this.description,
    this.clientId,
    this.expertId,
    this.status,
    this.priority,
    required this.attachment,
    this.solution,
    this.rating,
    this.comment,
  });

  Query copyWith({
    int? id,
    String? title,
    String? description,
    int? clientId,
    dynamic expertId,
    String? status,
    String? priority,
    File? attachment,
    dynamic solution,
    dynamic rating,
    dynamic comment,
  }) {
    return Query(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      clientId: clientId ?? this.clientId,
      expertId: expertId ?? this.expertId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      attachment: attachment ?? this.attachment,
      solution: solution ?? this.solution,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      clientId: json["client_id"],
      expertId: json["expert_id"],
      status: json["status"],
      priority: json["priority"],
      attachment: json["attachment"],
      solution: json["solution"],
      rating: json["rating"],
      comment: json["comment"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "client_id": clientId,
        "expert_id": expertId,
        "status": status,
        "priority": priority,
        "attachment": attachment,
        "solution": solution,
        "rating": rating,
        "comment": comment,
      };

  Map<String, dynamic> postJson() => {
        "title": title,
        "description": description,
        "attachment": attachment,
      };

  @override
  String toString() {
    return "$id, $title, $description, $clientId, $expertId, $status, $priority, $attachment, $solution, $rating, $comment, ";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        clientId,
        expertId,
        status,
        priority,
        attachment,
        solution,
        rating,
        comment,
      ];
}
