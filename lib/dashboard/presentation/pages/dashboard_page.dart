import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Global/Theming/bloc/theme_manager_bloc.dart';

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
          actions: [
            Switch(
              value:
                  context.read<ThemeManagerBloc>().themeMode == ThemeMode.dark,
              onChanged: (value) =>
                  context.read<ThemeManagerBloc>().add(SwitchThemeEvent(value)),
            )
          ],
        ),
        body: const Center(
          child: Text("Welcome"),
        ),
      );
    });
  }
}
