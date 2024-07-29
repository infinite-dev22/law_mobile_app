import 'package:dirm_attorneys_mobile/Global/Theming/bloc/theme_manager_bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Theming/theme.dart';
import 'package:dirm_attorneys_mobile/root/presentation/bloc/nav_bar_bloc.dart';
import 'package:dirm_attorneys_mobile/root/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ThemeManagerBloc()),
      BlocProvider(create: (context) => NavBarBloc()),
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
