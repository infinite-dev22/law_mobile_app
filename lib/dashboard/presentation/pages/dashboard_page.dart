import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dirm_attorneys_mobile/Global/Theming/bloc/theme_manager_bloc.dart';
import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/app_drawer.dart';
import 'package:dirm_attorneys_mobile/dashboard/presentation/widget/dashboard_item.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double sigmaX = 5;
    const double sigmaY = 5;
    var gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,mainAxisExtent: 100
    );

    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.primary.withOpacity(.05),
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lighterColor,
        ),
        drawer: const AppDrawer(),
        body: GridView(
          gridDelegate: gridDelegate,
          padding: const EdgeInsets.only(top: 16, left: 15),
          children: [
            DashboardItem(
              image: "assets/images/cases.png",
              name: "Cases",
              onTap: () => GoRouter.of(context).pushNamed('cases'),
            ),
            DashboardItem(
              image: "assets/images/issues.png",
              name: "Issues",
              onTap: () => GoRouter.of(context).pushNamed('issues'),
            ),
            DashboardItem(
              image: "assets/images/certificates.png",
              name: "Certificates",
              onTap: () => GoRouter.of(context).pushNamed('certificates'),
            ),
            DashboardItem(
              image: "assets/images/documents.png",
              name: "Documents",
              onTap: () => GoRouter.of(context).pushNamed('documents'),
            ),
            DashboardItem(
              image: "assets/images/attorneys.png",
              name: "Attorneys",
              onTap: () => GoRouter.of(context).pushNamed('attorneys'),
            ),
            DashboardItem(
              image: "assets/images/appointments.png",
              name: "Appointments",
              onTap: () => GoRouter.of(context).pushNamed('appointments'),
            ),
            DashboardItem(
              image: "assets/images/publications.png",
              name: "Publications",
              onTap: () => GoRouter.of(context).pushNamed('publications'),
            ),
            DashboardItem(
              image: "assets/images/queries.png",
              name: "Queries",
              onTap: () => GoRouter.of(context).pushNamed('queries'),
            ),
          ],
        ),
      );
    });
  }
}
