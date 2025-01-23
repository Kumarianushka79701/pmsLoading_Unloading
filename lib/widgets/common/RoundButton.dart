import 'package:flutter/material.dart';
import 'package:project/utils/color_extensions.dart';

enum RoundButtonType { primary, secondary }

class RoundButton extends StatelessWidget {
  final Widget title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? loadingIndicator;
  final double width; // Added width parameter

  const RoundButton({
    Key? key,
    required this.title,
    this.type = RoundButtonType.primary,
    required this.onPressed,
    this.isLoading = false,
    this.loadingIndicator,
    this.width = double.infinity, // Default to full-width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(51), // Set radius to 51
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 50), // Set the custom width
          elevation: 0,
          backgroundColor: type == RoundButtonType.primary
              ? AppColors.primary
              : AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(51), // Set radius to 51
          ),
        ),
        child: isLoading
            ? loadingIndicator ??
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    type == RoundButtonType.primary
                        ? Colors.white
                        : AppColors.primaryText,
                  ),
                )
            : title,
      ),
    );
  }
}
