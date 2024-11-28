import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:project/utils/colors.dart';

class RoundTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool isUpperCase;

  const RoundTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.isUpperCase = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          helperText: '',
          fillColor: AppColors.backgroundText,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ParcelColors.catalinaBlue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
            gapPadding: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red[600]!,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red[600]!,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorStyle: TextStyle(color: Colors.red[600]),
          floatingLabelBehavior: FloatingLabelBehavior.auto, // Label floats above when focused
          hintText: hintText,
          labelText: labelText, // Add label text
          prefixIcon: prefixIcon, // Add prefix icon
          suffixIcon: suffixIcon, // Add suffix icon
          hintStyle: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        inputFormatters: isUpperCase
            ? [UpperCaseTextFormatter()] // Apply uppercase formatting if true
            : [],
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

/// Custom `TextInputFormatter` for converting to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
