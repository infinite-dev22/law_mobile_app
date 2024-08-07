import 'package:equatable/equatable.dart';

class LoginErrorResponseModel extends Equatable {
  const LoginErrorResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final int? data;

  LoginErrorResponseModel copyWith({
    bool? status,
    String? message,
    int? data,
  }) {
    return LoginErrorResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory LoginErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginErrorResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
