import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 420;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1290 &&
      MediaQuery.of(context).size.width > 420;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1290;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.isPhone) {
          return mobile;
        }
        if (context.isTablet) {
          return tablet;
        }
        if (MyPlatform.isDesktop) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
