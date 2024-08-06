import 'package:equatable/equatable.dart';

import '../../../Global/data/model/user_model.dart';

class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  LoginResponseModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) {
    return LoginResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}

class Data extends Equatable {
  const Data({
    required this.user,
    required this.token,
  });

  final UserModel? user;
  final String? token;

  Data copyWith({
    UserModel? user,
    String? token,
  }) {
    return Data(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };

  @override
  List<Object?> get props => [
        user,
        token,
      ];
}
