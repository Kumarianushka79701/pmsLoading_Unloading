import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isUpperCase;
  final String? Function(String?) validator;

  const RoundTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isUpperCase = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0), // Increased border radius
          borderSide: const BorderSide(
            color: ParcelColors.catalinaBlue, // Default border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0), // Same border radius
          borderSide: const BorderSide(
            color: ParcelColors.brandeisblue, // Catalina Blue for enabled state
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0), // Same border radius
          borderSide: const BorderSide(
            color: ParcelColors.catalinaBlue, // Catalina Blue for focused state
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
