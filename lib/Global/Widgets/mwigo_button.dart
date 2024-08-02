import 'package:flutter/material.dart';

import '../Variables/colors.dart';

class MwigoButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final bool busy;
  final bool outlined;
  final double width;

  const MwigoButton({
    super.key,
    this.text = "Button",
    this.disabled = false,
    this.busy = false,
    this.outlined = false,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      duration: const Duration(milliseconds: 350),
      width: width,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: outlined
            ? Colors.transparent
            : disabled
                ? AppColors.disabled
                : Theme.of(context).colorScheme.primary,
        border: outlined
            ? Border.all(
                color: disabled
                    ? AppColors.disabled
                    : Theme.of(context).colorScheme.primary,
                width: 1,
              )
            : null,
      ),
      child: busy
          ? CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                outlined
                    ? disabled
                        ? AppColors.disabled
                        : Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
              strokeWidth: 4,
            )
          : Text(
              text,
              style: TextStyle(
                color: outlined
                    ? disabled
                        ? AppColors.disabled
                        : Theme.of(context).colorScheme.primary
                    : Colors.white,
              ),
            ),
    );
  }
}
