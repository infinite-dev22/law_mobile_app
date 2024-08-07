import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../Global/Variables/app_runtime_values.dart';
import '../../../Global/Variables/colors.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.child});

  final Widget child;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController controller = PageController();

  @override
  void initState() {
    currentUserToken = 'your_token_after_successful_login';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        destinations: _destinations(),
        selectedIndex: _calculateSelectedIndex(context),
        indicatorColor: AppColors.primaryLight,
        onDestinationSelected: (value) => _onItemTapped(value, context),
      ),
      body: widget.child,
    );
  }

  List<NavigationDestination> _destinations() {
    return [
      const NavigationDestination(
        label: "Dashboard",
        icon: Icon(FeatherIcons.home),
      ),
      const NavigationDestination(
        label: "Issues",
        icon: Icon(FeatherIcons.fileText),
      ),
      const NavigationDestination(
        label: "Documents",
        icon: Icon(FeatherIcons.file),
      ),
      const NavigationDestination(
        label: "Certificates",
        icon: Icon(FeatherIcons.layout),
      ),
      const NavigationDestination(
        label: "Cases",
        icon: Icon(FeatherIcons.briefcase),
      ),
    ];
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.contains('dashboard')) {
      return 0;
    }
    if (location.contains('issues')) {
      return 1;
    }
    if (location.contains('documents')) {
      return 2;
    }
    if (location.contains('certificates')) {
      return 3;
    }
    if (location.contains('cases')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed('dashboard');
      case 1:
        GoRouter.of(context).goNamed('issues');
      case 2:
        GoRouter.of(context).goNamed('documents');
      case 3:
        GoRouter.of(context).goNamed('certificates');
      case 4:
        GoRouter.of(context).goNamed('cases');
    }
  }
}
