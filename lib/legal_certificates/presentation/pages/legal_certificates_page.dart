import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';

class LegalCertificatesPage extends StatelessWidget {
  const LegalCertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Legal Certificates"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text("Legal Certificates"),
      ),
    );
  }
}
