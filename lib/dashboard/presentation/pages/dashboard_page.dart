import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgLightColor,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text("Welcome"),
      ),
    );
  }
}
