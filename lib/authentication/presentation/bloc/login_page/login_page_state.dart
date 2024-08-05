part of 'login_page_bloc.dart';

enum LoginPageStatus {
  initial,
  success,
  loading,
  error,
}

extension LoginPageStatusX on LoginPageStatus {
  bool get isInitial => this == LoginPageStatus.initial;

  bool get isSuccess => this == LoginPageStatus.success;

  bool get isLoading => this == LoginPageStatus.loading;

  bool get isError => this == LoginPageStatus.error;
}

@immutable
class LoginPageState extends Equatable {
  final LoginPageStatus status;

  const LoginPageState({
    this.status = LoginPageStatus.initial,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,
  ];

  LoginPageState copyWith({
    LoginPageStatus? status,
    bool? isLoginLoading,
    String? message,
  }) {
    return LoginPageState(
      status: status ?? this.status,
    );
  }
}

