import 'package:dirm_attorneys_mobile/Global/Variables/app_runtime_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../Theming/bloc/theme_manager_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${authData.data!.user!.name}"),
            accountEmail: Text("${authData.data!.user!.email}"),
            currentAccountPicture: const CircleAvatar(
              foregroundImage: AssetImage("assets/images/user.jpg"),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/app_backgroud.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesome.calendar_check),
            title: const Text("Appointments"),
            onTap: () => GoRouter.of(context).pushNamed('appointments'),
          ),
          ListTile(
            leading: const Icon(FontAwesome.newspaper),
            title: const Text("Publications"),
            onTap: () => GoRouter.of(context).pushNamed('publications'),
          ),
          ListTile(
            leading: const Icon(HeroIcons.briefcase),
            title: const Text("Attorneys"),
            onTap: () => GoRouter.of(context).pushNamed('attorneys'),
          ),
          ListTile(
            leading: const Icon(HeroIcons.clipboard_document_list),
            title: const Text("Queries"),
            onTap: () => GoRouter.of(context).pushNamed('queries'),
          ),
          const Divider(),
          ListTile(
            leading: (Theme.of(context).brightness == Brightness.dark)
                ? const Icon(FontAwesome.sun)
                : const Icon(FontAwesome.moon),
            title: Text((Theme.of(context).brightness == Brightness.dark)
                ? "Light mode"
                : "Dark mode"),
            onTap: () => context.read<ThemeManagerBloc>().add(SwitchThemeEvent(
                !(Theme.of(context).brightness == Brightness.dark))),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text("Log out"),
            onTap: () => GoRouter.of(context).goNamed('login'),
          ),
        ],
      ),
    );
  }
}
