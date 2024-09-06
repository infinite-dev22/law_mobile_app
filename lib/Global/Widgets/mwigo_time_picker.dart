import 'package:flutter/material.dart';

class MwigoTimePicker extends StatefulWidget {
  final String label;
  final bool disabled;
  final TextEditingController? controller;

  const MwigoTimePicker({
    super.key,
    this.label = "",
    this.disabled = false,
    this.controller,
  });

  @override
  State<MwigoTimePicker> createState() => _MwigoTimePickerState();
}

class _MwigoTimePickerState extends State<MwigoTimePicker> {
  bool _focused = false;
  TimeOfDay? time = TimeOfDay.now();

  void _handleFocusHighlight(bool value) {
    setState(() {
      _focused = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localization = MaterialLocalizations.of(context);
    return GestureDetector(
      onTap: () async {
        time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        widget.controller?.text = localization.formatTimeOfDay(time!);
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 16),
            ),
            FocusableActionDetector(
              onShowFocusHighlight: _handleFocusHighlight,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: (_focused == true)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 12,
                      child: Text(
                        (time != null)
                            ? localization.formatTimeOfDay(
                                time!) /*"${time?.hour} : ${time?.minute}"*/
                            : "",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.calendar_month_rounded,
                          color: (_focused == true)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
