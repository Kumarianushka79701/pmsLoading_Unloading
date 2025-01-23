import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart'; 

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity, // Default to full width
    this.height = 50.0, // Default height
    this.borderColor = ParcelColors.brandeisblue, // Default border color
    this.textColor = ParcelColors.brandeisblue, // Default text color
    this.borderRadius = 32.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Custom width
      height: height, // Custom height
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(color: textColor,fontSize: 18,fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
