import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  const LoginModel({
    required this.username,
    required this.password,
  });

  final String? username;
  final String? password;

  LoginModel copyWith({
    String? username,
    String? password,
  }) {
    return LoginModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json["username"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}

/*
{
	"username": "Admin",
	"password": "password"
}*/
