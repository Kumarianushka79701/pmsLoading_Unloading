import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = ParcelColors.brandeisblue,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      ),
    );
  }
}
