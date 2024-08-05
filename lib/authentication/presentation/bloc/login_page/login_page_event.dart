part of 'login_page_bloc.dart';

sealed class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class LoginPostEvent extends LoginPageEvent {
  final LoginModel loginModel;

  const LoginPostEvent(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}
