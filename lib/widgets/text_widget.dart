import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextWidget({
    Key? key,
    required this.label,
    this.textAlign,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor ?? Colors.black, // Default to black if not provided
        fontSize: fontSize ?? 14.0, // Default font size
        fontWeight: fontWeight ?? FontWeight.normal, // Default font weight
      ),
    );
  }
}
