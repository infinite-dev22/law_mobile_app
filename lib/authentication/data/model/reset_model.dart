import 'package:equatable/equatable.dart';

class ResetModel extends Equatable {
  const ResetModel({
    required this.email,
  });

  final String? email;

  ResetModel copyWith({
    String? email,
  }) {
    return ResetModel(
      email: email ?? this.email,
    );
  }

  factory ResetModel.fromJson(Map<String, dynamic> json) {
    return ResetModel(
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
      };

  @override
  List<Object?> get props => [
        email,
      ];
}
