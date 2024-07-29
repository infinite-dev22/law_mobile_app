import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';

class LegalIssuesPage extends StatelessWidget {
  const LegalIssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgLightColor,
      appBar: AppBar(
        title: const Text("Legal Issues"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text("Legal Issues"),
      ),
    );
  }
}
