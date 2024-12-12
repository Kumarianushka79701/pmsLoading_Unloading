import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? color;
  final Color textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  const CustomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.color,
    this.textColor = Colors.white,
    this.borderRadius = 15.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.iconSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        padding: padding,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                prefixIcon,
                size: iconSize,
                color: textColor,
              ),
            ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                suffixIcon,
                size: iconSize,
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}
