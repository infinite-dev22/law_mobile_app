import 'package:flutter/material.dart';

class NoCertificatesWidget extends StatelessWidget {
  const NoCertificatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No certificates available now"),
    );
  }
}
