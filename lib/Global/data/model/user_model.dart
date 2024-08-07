import 'package:equatable/equatable.dart';

import '../../../authentication/data/model/role_model.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic phone;
  final dynamic avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<RoleModel> roles;

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    dynamic emailVerifiedAt,
    dynamic phone,
    dynamic avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<RoleModel>? roles,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roles: roles ?? this.roles,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      phone: json["phone"],
      avatar: json["avatar"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      roles: json["roles"] == null
          ? []
          : List<RoleModel>.from(
              json["roles"]!.map((x) => RoleModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "avatar": avatar,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "roles": roles.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        emailVerifiedAt,
        phone,
        avatar,
        createdAt,
        updatedAt,
        roles,
      ];
}
