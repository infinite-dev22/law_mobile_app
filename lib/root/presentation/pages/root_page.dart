import 'package:dirm_attorneys_mobile/legal_cases/presentation/pages/legal_cases_page.dart';
import 'package:dirm_attorneys_mobile/legal_certificates/presentation/pages/legal_certificates_page.dart';
import 'package:dirm_attorneys_mobile/legal_documents/presentation/pages/legal_documents_page.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/pages/legal_issues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

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
          foregroundColor: AppColors.lighterColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("John Doe"),
                accountEmail: Text("johndoe@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  foregroundImage: AssetImage("assets/images/user.jpg"),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/app_backgroud.jpg"))),
              ),
              ListTile(
                leading: const Icon(FontAwesome.calendar_check),
                title: const Text("Appointments"),
                onTap: () => GoRouter.of(context).goNamed('appointments'),
              ),
              ListTile(
                leading: const Icon(FontAwesome.newspaper),
                title: const Text("Publications"),
                onTap: () => GoRouter.of(context).goNamed('publications'),
              ),
              ListTile(
                leading: const Icon(HeroIcons.briefcase),
                title: const Text("Attorneys"),
                onTap: () => GoRouter.of(context).goNamed('attorneys'),
              ),
              ListTile(
                leading: const Icon(HeroIcons.clipboard_document_list),
                title: const Text("Queries"),
                onTap: () => GoRouter.of(context).goNamed('queries'),
              ),
              const Divider(),
              ListTile(
                leading: (Theme.of(context).brightness == Brightness.dark)
                    ? const Icon(FontAwesome.sun)
                    : const Icon(FontAwesome.moon),
                title: Text((Theme.of(context).brightness == Brightness.dark)
                    ? "Light mode"
                    : "Dark mode"),
                onTap: () => context.read<ThemeManagerBloc>().add(
                    SwitchThemeEvent(
                        !(Theme.of(context).brightness == Brightness.dark))),
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Log out"),
                onTap: () => GoRouter.of(context).goNamed('login'),
              ),
            ],
          ),
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
