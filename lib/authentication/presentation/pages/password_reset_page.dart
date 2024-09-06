import 'dart:ui';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:dirm_attorneys_mobile/authentication/data/model/reset_model.dart';
import 'package:dirm_attorneys_mobile/authentication/presentation/bloc/login_page/login_page_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../widget/mwigo_auth_text_field.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
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
                              const Text("Reset Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              MwigoAuthTextField(
                                controller: emailController,
                                hintText: "Email",
                                validationText: "Email can't be empty",
                                enabled: !state.status.isResetLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              LoadingButton(
                                text: "Reset Password",
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    var resetModel = ResetModel(
                                        email: emailController.text.trim());
                                    context
                                        .read<LoginPageBloc>()
                                        .add(PasswordResetEvent(resetModel));
                                  }
                                },
                                busy: state.status.isResetLoading,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Back to ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                        text: "Login",
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
      listener: (BuildContext context, LoginPageState state) {
        if (state.status.isResetSuccess) {
          Toast.show(state.message!,
              duration: Toast.lengthLong, gravity: Toast.bottom);
          GoRouter.of(context).goNamed("login");
        }
        if (state.status.isResetError) {
          Toast.show(state.message!,
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      },
    );
  }
}
