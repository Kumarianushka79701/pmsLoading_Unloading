import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/custom_toggle_button.dart';
import 'package:provider/provider.dart';

class DropdownRadioWidget extends StatelessWidget {
  final String? title;
  final List<String> options;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? radioColor;
  final TextEditingController controller;
  final TextEditingController? titleController; // New title controller

  const DropdownRadioWidget({
    super.key,
    this.title,
    required this.options,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.radioColor,
    required this.controller,
    this.titleController, // Added title controller
  });

  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (titleController != null)
                Text(
                  titleController!.text, // Use titleController value
                  style: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: fontWeight ?? FontWeight.bold,
                    color: textColor ?? ParcelColors.catalinaBlue,
                  ),
                )
              else if (title != null && title!.isNotEmpty)
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: fontWeight ?? FontWeight.bold,
                    color: textColor ?? ParcelColors.catalinaBlue,
                  ),
                ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.shade300),
            ],
          ),
          content: Consumer<LoadingProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: options
                    .map((option) => _buildRadioTile(context, option))
                    .toList(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRadioTile(BuildContext context, String value) {
    return Consumer<LoadingProvider>(
      builder: (context, provider, child) {
        return RadioListTile<String>(
          title: Text(
            value,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: textColor ?? Colors.black,
            ),
          ),
          value: value,
          groupValue: provider.selectedValue,
          onChanged: (val) {
            provider.selectValue(val!);
            controller.text = val; // Update the text controller
            Navigator.pop(context); // Close dialog on selection
          },
          activeColor: radioColor ?? ParcelColors.catalinaBlue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            hintText: titleController?.text ??
                title, // Use titleController text if provided
            hintStyle: TextStyle(
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: textColor ?? ParcelColors.catalinaBlue,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.arrow_drop_down,
                color: ParcelColors.catalinaBlue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: ParcelColors.gray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: ParcelColors.gray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: ParcelColors.gray, width: 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          onTap: () => _showSelectionDialog(context),
        );
      },
    );
  }
}
