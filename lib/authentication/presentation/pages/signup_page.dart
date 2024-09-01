import 'dart:ui';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../data/model/signup_model.dart';
import '../bloc/signup_page/signup_page_bloc.dart';
import '../widget/mwigo_auth_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNamesController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    const double sigmaX = 5;
    const double sigmaY = 5;
    const double opacity = 0.2;
    final formKey = GlobalKey<FormState>();
    ToastContext().init(context);

    return BlocConsumer<SignUpPageBloc, SignUpPageState>(
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
                              const Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              MwigoAuthTextField(
                                controller: fullNamesController,
                                hintText: "Name (Full Names)",
                                validationText: "Name can't be empty",
                                enabled: !state.status.isLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              MwigoAuthTextField(
                                controller: emailController,
                                hintText: "Email",
                                validationText: "Email can't be empty",
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              MwigoAuthTextField(
                                controller: confirmPasswordController,
                                hintText: "Password (Confirm)",
                                validationText: "Field can't be empty",
                                obscureText: true,
                                enabled: !state.status.isLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              LoadingButton(
                                text: "Create My Account",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    var signUpModel = SignUpModel(
                                        fullNames:
                                            fullNamesController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim());
                                    context
                                        .read<SignUpPageBloc>()
                                        .add(SignUpPostEvent(signUpModel));
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
                                      text: "Already have an account? ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextSpan(
                                        text: "Login",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                              .goNamed('login')),
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
      listener: (BuildContext context, SignUpPageState state) {
        if (state.status.isInitial) {
          Toast.show(state.message!,
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isSuccess) {
          Toast.show(state.message!,
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).goNamed("login");
        }
        if (state.status.isError) {
          Toast.show(state.message!,
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
      },
    );
  }
}
