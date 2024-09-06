import 'package:flutter/material.dart';

class MwigoTextField extends StatelessWidget {
  final String label;
  final bool disabled;
  final bool readOnly;
  final TextEditingController? controller;

  const MwigoTextField({
    super.key,
    this.label = "",
    this.disabled = false,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          TextFormField(
            enabled: !disabled,
            readOnly: readOnly,
            maxLength: 45,
            controller: controller,
            validator: (text) {
              if (text!.isEmpty) {
                return "$label can not be empty";
              }
              if (!(text.length > 5)) {
                return "Enter a $label of more than 5 characters";
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0,
              ),
              isDense: true,
              counter: null,
              counterText: "",
              enabled: !disabled,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
