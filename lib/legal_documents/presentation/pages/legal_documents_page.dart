import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';

class LegalDocumentsPage extends StatelessWidget {
  const LegalDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgLightColor,
      appBar: AppBar(
        title: const Text("Legal Documents"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text("Legal Documents"),
      ),
    );
  }
}
