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
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor ?? Colors.black, 
          fontSize: fontSize ?? 16, 
          fontWeight: fontWeight ?? FontWeight.normal, 
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ??
              BorderRadius.circular(30), 
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey, 
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: textColor ?? Colors.black, 
                    fontSize: fontSize ?? 16, 
                    fontWeight:
                        fontWeight ?? FontWeight.normal, 
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
