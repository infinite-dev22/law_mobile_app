import 'package:equatable/equatable.dart';

import '../../../Global/data/model/client_model.dart';

class LegalCertificate extends Equatable {
  const LegalCertificate({
    required this.id,
    required this.clientId,
    required this.title,
    required this.slug,
    required this.description,
    required this.uploadedFilePath,
    required this.uploadedFileName,
    required this.adviceFilePath,
    required this.adviceFileName,
    required this.advice,
    required this.comment,
    required this.assignedTo,
    required this.deadline,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.issueStatus,
    required this.clients,
  });

  final int? id;
  final String? clientId;
  final String? title;
  final String? slug;
  final String? description;
  final String? uploadedFilePath;
  final String? uploadedFileName;
  final dynamic adviceFilePath;
  final dynamic adviceFileName;
  final dynamic advice;
  final dynamic comment;
  final dynamic assignedTo;
  final dynamic deadline;
  final dynamic priority;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? issueStatus;
  final Client? clients;

  LegalCertificate copyWith({
    int? id,
    String? clientId,
    String? title,
    String? slug,
    String? description,
    String? uploadedFilePath,
    String? uploadedFileName,
    dynamic adviceFilePath,
    dynamic adviceFileName,
    dynamic advice,
    dynamic comment,
    dynamic assignedTo,
    dynamic deadline,
    dynamic priority,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? issueStatus,
    Client? clients,
  }) {
    return LegalCertificate(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      uploadedFilePath: uploadedFilePath ?? this.uploadedFilePath,
      uploadedFileName: uploadedFileName ?? this.uploadedFileName,
      adviceFilePath: adviceFilePath ?? this.adviceFilePath,
      adviceFileName: adviceFileName ?? this.adviceFileName,
      advice: advice ?? this.advice,
      comment: comment ?? this.comment,
      assignedTo: assignedTo ?? this.assignedTo,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      issueStatus: issueStatus ?? this.issueStatus,
      clients: clients ?? this.clients,
    );
  }

  factory LegalCertificate.fromJson(Map<String, dynamic> json) {
    return LegalCertificate(
      id: json["id"],
      clientId: json["client_id"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      uploadedFilePath: json["uploaded_file_path"],
      uploadedFileName: json["uploaded_file_name"],
      adviceFilePath: json["advice_file_path"],
      adviceFileName: json["advice_file_name"],
      advice: json["advice"],
      comment: json["comment"],
      assignedTo: json["assigned_to"],
      deadline: json["deadline"],
      priority: json["priority"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      issueStatus: json["issue_status"],
      clients:
          json["clients"] == null ? null : Client.fromJson(json["clients"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "title": title,
        "slug": slug,
        "description": description,
        "uploaded_file_path": uploadedFilePath,
        "uploaded_file_name": uploadedFileName,
        "advice_file_path": adviceFilePath,
        "advice_file_name": adviceFileName,
        "advice": advice,
        "comment": comment,
        "assigned_to": assignedTo,
        "deadline": deadline,
        "priority": priority,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "issue_status": issueStatus,
        "clients": clients?.toJson(),
      };

  Map<String, dynamic> postJson() => {
        "title": title,
        "description": description,
        "file": adviceFilePath,
      };

  @override
  List<Object?> get props => [
        id,
        clientId,
        title,
        slug,
        description,
        uploadedFilePath,
        uploadedFileName,
        adviceFilePath,
        adviceFileName,
        advice,
        comment,
        assignedTo,
        deadline,
        priority,
        status,
        createdAt,
        updatedAt,
        deletedAt,
        issueStatus,
        clients,
      ];
}
