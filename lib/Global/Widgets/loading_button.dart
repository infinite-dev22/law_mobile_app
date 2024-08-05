import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final bool busy;
  final bool outlined;
  final double width;
  final Function() onTap;

  const LoadingButton({
    super.key,
    this.text = "Button",
    this.disabled = false,
    this.busy = false,
    this.outlined = false,
    this.width = double.infinity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return (!disabled && !busy)
        ? Bounceable(
            onTap: onTap,
            child: MwigoButton(
              text: text,
              outlined: outlined,
              width: width,
            ),
          )
        : MwigoButton(
            text: text,
            disabled: disabled,
            busy: busy,
            outlined: outlined,
            width: width,
          );
  }
}
