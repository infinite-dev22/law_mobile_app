import 'package:dirm_attorneys_mobile/legal_cases/presentation/pages/legal_cases_page.dart';
import 'package:dirm_attorneys_mobile/legal_certificates/presentation/pages/legal_certificates_page.dart';
import 'package:dirm_attorneys_mobile/legal_documents/presentation/pages/legal_documents_page.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/pages/legal_issues_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(builder: (context, state) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: NavigationBar(
          destinations: _destinations(),
          selectedIndex: context.read<NavBarBloc>().state.idSelected,
          indicatorColor: AppColors.primary,
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
