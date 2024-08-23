import 'dart:ui';

import 'package:dirm_attorneys_mobile/dashboard/presentation/widget/dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../Global/Theming/bloc/theme_manager_bloc.dart';
import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double sigmaX = 5;
    const double sigmaY = 5;
    const double opacity = 0.2;
    var gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3);

    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lighterColor,
        ),
        drawer: const AppDrawer(),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/app_backgroud.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 50, right: 20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(opacity),
                ),
                child: Center(
                  child: SizedBox(
                    height: 500,
                    width: 500,
                    child: GridView(
                      gridDelegate: gridDelegate,
                      padding: const EdgeInsets.all(20),
                      children: [
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('issues'),
                            icon: FeatherIcons.fileText),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('documents'),
                            icon: FeatherIcons.file),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('certificates'),
                            icon: FeatherIcons.layout),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('cases'),
                            icon: FeatherIcons.briefcase),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('appointments'),
                            icon: FontAwesome.calendar_check),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('publications'),
                            icon: FontAwesome.newspaper),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('attorneys'),
                            icon: HeroIcons.briefcase),
                        DashboardItem(
                            onTap: () =>
                                GoRouter.of(context).pushNamed('queries'),
                            icon: HeroIcons.clipboard_document_list),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
