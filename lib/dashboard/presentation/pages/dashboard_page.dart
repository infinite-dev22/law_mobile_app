import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Global/Theming/bloc/theme_manager_bloc.dart';
import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lighterColor,
        ),
        drawer: const AppDrawer(),
        body: const Center(
          child: Text("Welcome"),
        ),
      );
    });
  }
}
