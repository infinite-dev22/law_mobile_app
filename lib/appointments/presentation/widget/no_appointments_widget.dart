import 'package:flutter/material.dart';

class NoAppointmentsWidget extends StatelessWidget {
  const NoAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No appointments available now"),
    );
  }
}
