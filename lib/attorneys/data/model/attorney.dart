import 'package:equatable/equatable.dart';

class Attorney extends Equatable {
  const Attorney({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.avatar,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic phone;
  final dynamic avatar;
  final dynamic userType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Attorney copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    dynamic emailVerifiedAt,
    dynamic phone,
    dynamic avatar,
    dynamic userType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attorney(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Attorney.fromJson(Map<String, dynamic> json) {
    return Attorney(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      phone: json["phone"],
      avatar: json["avatar"],
      userType: json["user_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
        "user_type": userType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return name.toString();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        emailVerifiedAt,
        phone,
        avatar,
        userType,
        createdAt,
        updatedAt,
      ];
}
