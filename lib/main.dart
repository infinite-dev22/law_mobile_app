import 'package:dirm_attorneys_mobile/Global/Theming/bloc/theme_manager_bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Theming/theme.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'package:dirm_attorneys_mobile/root/presentation/bloc/nav_bar_bloc.dart';
import 'package:dirm_attorneys_mobile/root/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'legal_cases/presentation/bloc/legal_access_page/legal_cases_page_bloc.dart';
import 'legal_certificates/presentation/bloc/legal_certificates_page/legal_certificates_page_bloc.dart';
import 'legal_documents/presentation/bloc/legal_documents_page/legal_documents_page_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ThemeManagerBloc()),
      BlocProvider(create: (context) => NavBarBloc()),
      BlocProvider(create: (context) => LegalIssuesPagesBloc()),
      BlocProvider(create: (context) => LegalDocumentsPageBloc()),
      BlocProvider(create: (context) => LegalCertificatesPageBloc()),
      BlocProvider(create: (context) => LegalCasesPageBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dirm Attorneys',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: context.read<ThemeManagerBloc>().themeMode,
        home: const RootPage(),
      );
    });
  }
}
