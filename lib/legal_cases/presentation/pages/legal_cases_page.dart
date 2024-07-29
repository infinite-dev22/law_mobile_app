import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';

class LegalCasesPage extends StatelessWidget {
  const LegalCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgLightColor,
      appBar: AppBar(
        title: const Text("Legal Cases"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text("Legal Cases"),
      ),
    );
  }
}
