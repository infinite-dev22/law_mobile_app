import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../Global/data/model/client_model.dart';

class Publication extends Equatable {
  const Publication({
    required this.id,
    required this.clientId,
    required this.title,
    required this.description,
    required this.slug,
    required this.uploadedFilePath,
    required this.uploadedFileName,
    required this.certifiedFilePath,
    required this.certifiedFileName,
    required this.comment,
    required this.assignedTo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.issueStatus,
    required this.adviceFilePath,
    required this.clients,
    this.file,
  });

  const Publication.post({
    required this.title,
    required this.description,
    required this.file,
    this.id,
    this.clientId,
    this.slug,
    this.uploadedFilePath,
    this.uploadedFileName,
    this.certifiedFilePath,
    this.certifiedFileName,
    this.comment,
    this.assignedTo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.issueStatus,
    this.adviceFilePath,
    this.clients,
  });

  final int? id;
  final String? clientId;
  final String? title;
  final String? description;
  final String? slug;
  final String? uploadedFilePath;
  final String? uploadedFileName;
  final dynamic certifiedFilePath;
  final dynamic certifiedFileName;
  final dynamic comment;
  final dynamic assignedTo;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? issueStatus;
  final dynamic adviceFilePath;
  final Client? clients;
  final File? file;

  Publication copyWith({
    int? id,
    String? clientId,
    String? title,
    String? description,
    String? slug,
    String? uploadedFilePath,
    String? uploadedFileName,
    dynamic certifiedFilePath,
    dynamic certifiedFileName,
    dynamic comment,
    dynamic assignedTo,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? issueStatus,
    dynamic adviceFilePath,
    Client? clients,
  }) {
    return Publication(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      title: title ?? this.title,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      uploadedFilePath: uploadedFilePath ?? this.uploadedFilePath,
      uploadedFileName: uploadedFileName ?? this.uploadedFileName,
      certifiedFilePath: certifiedFilePath ?? this.certifiedFilePath,
      certifiedFileName: certifiedFileName ?? this.certifiedFileName,
      comment: comment ?? this.comment,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      issueStatus: issueStatus ?? this.issueStatus,
      adviceFilePath: adviceFilePath ?? this.adviceFilePath,
      clients: clients ?? this.clients,
    );
  }

  factory Publication.fromJson(Map<String, dynamic> json){
    return Publication(
      id: json["id"],
      clientId: json["client_id"],
      title: json["title"],
      description: json["description"],
      slug: json["slug"],
      uploadedFilePath: json["uploaded_file_path"],
      uploadedFileName: json["uploaded_file_name"],
      certifiedFilePath: json["certified_file_path"],
      certifiedFileName: json["certified_file_name"],
      comment: json["comment"],
      assignedTo: json["assigned_to"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      issueStatus: json["issue_status"],
      adviceFilePath: json["advice_file_path"],
      clients: json["clients"] == null ? null : Client.fromJson(json["clients"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "title": title,
    "description": description,
    "slug": slug,
    "uploaded_file_path": uploadedFilePath,
    "uploaded_file_name": uploadedFileName,
    "certified_file_path": certifiedFilePath,
    "certified_file_name": certifiedFileName,
    "comment": comment,
    "assigned_to": assignedTo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "issue_status": issueStatus,
    "advice_file_path": adviceFilePath,
    "clients": clients?.toJson(),
  };

  Map<String, dynamic> postJson() => {
    "title": title,
    "description": description,
    "file": file,
  };

  @override
  List<Object?> get props => [
    id, clientId, title, description, slug, uploadedFilePath, uploadedFileName, certifiedFilePath, certifiedFileName, comment, assignedTo, status, createdAt, updatedAt, deletedAt, issueStatus, adviceFilePath, clients, file ];

}