import 'package:flutter/material.dart';

import '../Variables/colors.dart';

class MwigoButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final bool busy;

  const MwigoButton({
    super.key,
    this.text = "Button",
    this.disabled = false,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      duration: const Duration(milliseconds: 350),
      width: double.infinity,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: disabled
              ? AppColors.disabled
              : Theme.of(context).colorScheme.primary),
      child: busy
          ? const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 4,
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
