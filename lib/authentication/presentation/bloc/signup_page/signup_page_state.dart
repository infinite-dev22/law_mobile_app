part of 'signup_page_bloc.dart';

enum SignUpPageStatus {
  initial,
  success,
  loading,
  error,
}

extension SignUpPageStatusX on SignUpPageStatus {
  bool get isInitial => this == SignUpPageStatus.initial;

  bool get isSuccess => this == SignUpPageStatus.success;

  bool get isLoading => this == SignUpPageStatus.loading;

  bool get isError => this == SignUpPageStatus.error;
}

@immutable
class SignUpPageState extends Equatable {
  final SignUpPageStatus status;
  final String? message;

  const SignUpPageState({
    this.status = SignUpPageStatus.initial,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];

  SignUpPageState copyWith({
    SignUpPageStatus? status,
    String? message,
  }) {
    return SignUpPageState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
