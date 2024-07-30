import 'package:dirm_attorneys_mobile/legal_cases/presentation/pages/legal_cases_page.dart';
import 'package:dirm_attorneys_mobile/legal_certificates/presentation/pages/legal_certificates_page.dart';
import 'package:dirm_attorneys_mobile/legal_documents/presentation/pages/legal_documents_page.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/pages/legal_issues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../Global/Theming/bloc/theme_manager_bloc.dart';
import '../../../Global/Variables/app_runtime_values.dart';
import '../../../Global/Variables/colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../bloc/nav_bar_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    currentUserToken = 'your_token_after_successful_login';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Dirm Attorneys"),
          backgroundColor: AppColors.primary,
          actions: [
            FlutterSwitch(
                width: 60,
                activeIcon: const Icon(
                  FeatherIcons.moon,
                  color: AppColors.gray,
                  size: 100,
                ),
                activeColor: Color(0xFF271052),
                activeToggleColor: AppColors.purple,
                inactiveIcon: const Icon(
                  FeatherIcons.sun,
                  color: AppColors.orange,
                  size: 100,
                ),
                inactiveColor: AppColors.lighterColor,
                inactiveToggleColor: AppColors.darkerColor,
                value: Theme.of(context).brightness == Brightness.dark,
                onToggle: (value) => context
                    .read<ThemeManagerBloc>()
                    .add(SwitchThemeEvent(value))),
            PopupMenuButton(
              icon: const Icon(
                Icons.person_rounded,
                size: 35,
                color: Colors.white,
              ), //use this icon
              onSelected: (String item) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Log Out',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app_rounded),
                    title: Text('Log Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          destinations: _destinations(),
          selectedIndex: context.read<NavBarBloc>().state.idSelected,
          indicatorColor: AppColors.primaryLight,
          onDestinationSelected: (value) =>
              context.read<NavBarBloc>().add(SwitchScreenEvent(value)),
        ),
        body: _pages()[context.read<NavBarBloc>().state.idSelected],
      );
    });
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

  List<Widget> _pages() {
    return [
      const DashboardPage(),
      const LegalIssuesPage(),
      const LegalDocumentsPage(),
      const LegalCertificatesPage(),
      const LegalCasesPage(),
    ];
  }
}
