part of 'login_page_bloc.dart';

enum LoginPageStatus {
  initial,
  success,
  resetSuccess,
  loading,
  resetLoading,
  error,
  resetError,
}

extension LoginPageStatusX on LoginPageStatus {
  bool get isInitial => this == LoginPageStatus.initial;

  bool get isSuccess => this == LoginPageStatus.success;

  bool get isResetSuccess => this == LoginPageStatus.resetSuccess;

  bool get isLoading => this == LoginPageStatus.loading;

  bool get isResetLoading => this == LoginPageStatus.resetLoading;

  bool get isError => this == LoginPageStatus.error;

  bool get isResetError => this == LoginPageStatus.resetError;
}

@immutable
class LoginPageState extends Equatable {
  final LoginPageStatus status;
  final String? message;

  const LoginPageState({
    this.status = LoginPageStatus.initial,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? message,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
