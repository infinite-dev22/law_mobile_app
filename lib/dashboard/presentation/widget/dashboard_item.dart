import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class DashboardItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;

  const DashboardItem({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: SizedBox(
        height: 10,
        width: 10,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Center(
            child: Icon(
              icon,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
