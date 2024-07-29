import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LegalIssueSuccessWidget extends StatelessWidget {
  const LegalIssueSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(builder: (context, state) => const Center(
      child: Text("Legal Issues"),
    ), listener: (context, state) {

    },);
  }
}
