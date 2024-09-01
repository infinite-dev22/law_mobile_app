import 'package:dirm_attorneys_mobile/Global/Theming/bloc/theme_manager_bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Theming/theme.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/bloc/appointment_page/appointments_page_bloc.dart';
import 'package:dirm_attorneys_mobile/attorneys/presentation/bloc/attorney_page/attorneys_page_bloc.dart';
import 'package:dirm_attorneys_mobile/authentication/presentation/pages/login_page.dart';
import 'package:dirm_attorneys_mobile/authentication/presentation/pages/signup_page.dart';
import 'package:dirm_attorneys_mobile/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dirm_attorneys_mobile/legal_cases/presentation/pages/legal_cases_page.dart';
import 'package:dirm_attorneys_mobile/legal_certificates/presentation/pages/legal_certificates_page.dart';
import 'package:dirm_attorneys_mobile/legal_documents/presentation/pages/legal_documents_page.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/pages/legal_issues_page.dart';
import 'package:dirm_attorneys_mobile/publications/presentation/bloc/publication_page/publications_page_bloc.dart';
import 'package:dirm_attorneys_mobile/publications/presentation/pages/publications_page.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/bloc/appointment_page/queries_page_bloc.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/pages/queries_page.dart';
import 'package:dirm_attorneys_mobile/root/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'appointments/presentation/pages/appointments_page.dart';
import 'attorneys/presentation/pages/attorneys_page.dart';
import 'authentication/presentation/bloc/login_page/login_page_bloc.dart';
import 'authentication/presentation/bloc/signup_page/signup_page_bloc.dart';
import 'legal_cases/presentation/bloc/legal_cases_page/legal_cases_page_bloc.dart';
import 'legal_certificates/presentation/bloc/legal_certificates_page/legal_certificates_page_bloc.dart';
import 'legal_documents/presentation/bloc/legal_documents_page/legal_documents_page_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ThemeManagerBloc()),
      BlocProvider(create: (context) => LoginPageBloc()),
      BlocProvider(create: (context) => SignUpPageBloc()),
    ],
    child: BlocProvider<ThemeManagerBloc>(
        create: (context) => ThemeManagerBloc()..add(InitialThemeEvent()),
        child: const MyApp()),
  ));
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  routes: [
    GoRoute(
      name: 'login',
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'signup',
      path: "/signup",
      builder: (context, state) => const SignUpPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => RootPage(
        child: child,
      ),
      routes: [
        GoRoute(
          name: 'dashboard',
          path: "/dashboard",
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          name: 'issues',
          path: "/issues",
          builder: (context, state) => BlocProvider(
            create: (context) => LegalIssuesPagesBloc(),
            child: const LegalIssuesPage(),
          ),
        ),
        GoRoute(
          name: 'documents',
          path: "/documents",
          builder: (context, state) => BlocProvider(
            create: (context) => LegalDocumentsPageBloc(),
            child: const LegalDocumentsPage(),
          ),
        ),
        GoRoute(
          name: 'certificates',
          path: "/certificates",
          builder: (context, state) => BlocProvider(
            create: (context) => LegalCertificatesPageBloc(),
            child: const LegalCertificatesPage(),
          ),
        ),
        GoRoute(
          name: 'cases',
          path: "/cases",
          builder: (context, state) => BlocProvider(
            create: (context) => LegalCasesPageBloc(),
            child: const LegalCasesPage(),
          ),
        ),
        GoRoute(
          name: 'appointments',
          path: "/appointments",
          builder: (context, state) => BlocProvider(
            create: (context) => AppointmentsPageBloc(),
            child: const AppointmentsPage(),
          ),
        ),
        GoRoute(
          name: 'publications',
          path: "/publications",
          builder: (context, state) => BlocProvider(
            create: (context) => PublicationsPageBloc(),
            child: const PublicationsPage(),
          ),
        ),
        GoRoute(
          name: 'attorneys',
          path: "/attorneys",
          builder: (context, state) => BlocProvider(
            create: (context) => AttorneysPageBloc(),
            child: const AttorneysPage(),
          ),
        ),
        GoRoute(
          name: 'queries',
          path: "/queries",
          builder: (context, state) => BlocProvider(
            create: (context) => QueriesPageBloc(),
            child: const QueriesPage(),
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Dirm Attorneys',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: context.read<ThemeManagerBloc>().themeMode,
      );
    });
  }
}
