import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color? labelColor;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? width;
  final FontWeight? fontWeight;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.onSaved,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.labelColor,
    this.textColor,
    this.borderColor,
    this.textSize,
    this.width,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: textSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: labelColor ?? Colors.grey,
            fontSize: textSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.w400,
          ),
          floatingLabelBehavior:
              FloatingLabelBehavior.never, 
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor ?? Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor ?? Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor ?? ParcelColors.gray),
          ),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
