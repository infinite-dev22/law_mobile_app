import 'package:equatable/equatable.dart';

class SignUpModel extends Equatable {
  const SignUpModel({
    required this.fullNames,
    required this.email,
    required this.contact,
    required this.password,
    required this.confirmPassword,
  });

  final String? fullNames;
  final String? email;
  final String? contact;
  final String? password;
  final String? confirmPassword;

  SignUpModel copyWith({
    String? fullNames,
    String? email,
    String? contact,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpModel(
      fullNames: fullNames ?? this.fullNames,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fullNames: json["fullnames"],
      email: json["email"],
      contact: json["contact"],
      password: json["password"],
      confirmPassword: json["confirm-password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fullnames": fullNames,
        "email": email,
        "contact": contact,
        "password": password,
        "confirm-password": confirmPassword,
      };

  @override
  List<Object?> get props => [
        fullNames,
        email,
        contact,
        password,
        confirmPassword,
      ];
}
