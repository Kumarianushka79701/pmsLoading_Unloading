
import 'package:flutter/material.dart';
import 'package:project/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: labelText == 'Booking Type',
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 15,color: ParcelColors.catalinaBlue,fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
