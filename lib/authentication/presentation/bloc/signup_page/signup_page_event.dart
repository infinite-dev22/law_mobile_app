part of 'signup_page_bloc.dart';

sealed class SignUpPageEvent extends Equatable {
  const SignUpPageEvent();
}

class SignUpPostEvent extends SignUpPageEvent {
  final SignUpModel loginModel;

  const SignUpPostEvent(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}
