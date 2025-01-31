import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final Color? labelColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.labelColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor ?? Colors.black, // Default label color
          fontSize: fontSize ?? 16, // Default font size
          fontWeight: fontWeight ?? FontWeight.normal, // Default font weight
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ??
              BorderRadius.circular(30), // Optional border radius
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey, // Default border color
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: textColor ?? Colors.black, // Default text color
                    fontSize: fontSize ?? 16, // Default font size
                    fontWeight:
                        fontWeight ?? FontWeight.normal, // Default font weight
                  ),
                ),
              ))
          .toList(),
      value: value,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
