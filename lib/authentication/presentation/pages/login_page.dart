import 'dart:ui';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:dirm_attorneys_mobile/authentication/data/model/login_model.dart';
import 'package:dirm_attorneys_mobile/authentication/presentation/bloc/login_page/login_page_bloc.dart';
import 'package:dirm_attorneys_mobile/authentication/presentation/widget/forgot_password_link.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../widget/mwigo_auth_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    const double sigmaX = 5;
    const double sigmaY = 5;
    const double opacity = 0.2;
    final formKey = GlobalKey<FormState>();
    ToastContext().init(context);

    return BlocConsumer<LoginPageBloc, LoginPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/app_backgroud.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 20, bottom: 50, right: 20),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(opacity),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Form(
                        key: formKey,
                        child: Center(
                          child: Column(
                            children: [
                              const Text("Sign in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              MwigoAuthTextField(
                                controller: usernameController,
                                hintText: "Username",
                                validationText: "Username can't be empty",
                                enabled: !state.status.isLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              MwigoAuthTextField(
                                controller: passwordController,
                                hintText: "Password",
                                validationText: "Password can't be empty",
                                obscureText: true,
                                enabled: !state.status.isLoading,
                              ),
                              const SizedBox(height: 16),
                              ForgotPasswordLink(
                                onTap: () => GoRouter.of(context)
                                    .goNamed('reset_password'),
                              ),
                              const SizedBox(height: 16),
                              LoadingButton(
                                text: "Let me in",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    var loginModel = LoginModel(
                                        username:
                                            usernameController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                    context
                                        .read<LoginPageBloc>()
                                        .add(LoginPostEvent(loginModel));
                                  }
                                },
                                busy: state.status.isLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                        text: "Create One",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => GoRouter.of(context)
                                              .goNamed('signup')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, LoginPageState state) {
        if (state.status.isInitial) {
          Toast.show(state.message!,
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
        if (state.status.isSuccess) {
          Toast.show(state.message!,
              duration: Toast.lengthLong, gravity: Toast.bottom);
          GoRouter.of(context).goNamed("dashboard");
        }
        if (state.status.isError) {
          Toast.show(state.message!,
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      },
    );
  }
}
