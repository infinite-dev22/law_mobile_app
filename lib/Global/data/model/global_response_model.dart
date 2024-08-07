import 'package:equatable/equatable.dart';

class GlobalResponseModel extends Equatable {
  GlobalResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final int? data;

  GlobalResponseModel copyWith({
    bool? status,
    String? message,
    int? data,
  }) {
    return GlobalResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory GlobalResponseModel.fromJson(Map<String, dynamic> json){
    return GlobalResponseModel(
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
    status, message, data, ];

}