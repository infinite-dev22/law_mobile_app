import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final bool busy;

  const LoadingButton({
    super.key,
    this.text = "Button",
    this.disabled = false,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return (!disabled && !busy)
        ? Bounceable(
            onTap: () {},
            child: MwigoButton(
              text: text,
            ),
          )
        : MwigoButton(
            text: text,
            disabled: disabled,
            busy: busy,
          );
  }
}
