import 'package:flutter/material.dart';

class MwigoAuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String validationText;
  final bool obscureText;
  final bool enabled;

  const MwigoAuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validationText,
    this.obscureText = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? validationText : null,
      controller: controller,
      obscureText: obscureText,
      maxLength: 45,
      enabled: enabled,
      decoration: InputDecoration(
        enabled: enabled,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        isDense: true,
        counter: null,
        counterText: "",
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 16,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
