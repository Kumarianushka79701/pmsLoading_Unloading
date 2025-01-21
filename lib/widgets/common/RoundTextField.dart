import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:project/utils/colors.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool isUpperCase;
  final String? Function(String?)? validator;

  const RoundTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.isUpperCase = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textCapitalization: isUpperCase
          ? TextCapitalization.characters
          : TextCapitalization.none,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey), // Added hint text color
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Increased for more roundness
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Match the same radius
          borderSide: const BorderSide(color: ParcelColors.brandeisblue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Match the same radius
          borderSide: const BorderSide(color: ParcelColors.paleCyan),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Match the same radius
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Match the same radius
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
