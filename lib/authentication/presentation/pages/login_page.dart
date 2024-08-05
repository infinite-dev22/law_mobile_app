import 'dart:ui';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../widget/mwigo_auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ToastContext toast = ToastContext();

  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final double _sigmaX = 5;

  // from 0-10
  final double _sigmaY = 5;

  // from 0-10
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    toast.init(context);

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
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 50, right: 20),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 1)
                          .withOpacity(_opacity),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        children: [
                          const Text("Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          MwigoAuthTextField(
                            controller: usernameController,
                            hintText: "Username",
                            validationText: "Username can't be empty",
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          MwigoAuthTextField(
                            controller: passwordController,
                            hintText: "Password",
                            validationText: "Password can't be empty",
                            obscureText: true,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          LoadingButton(
                            text: "Let me in",
                            onTap: () {},
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
  }
}
