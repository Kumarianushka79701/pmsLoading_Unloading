import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class STextFieldPassword extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool isPasswordField;
  final bool isRequiredField;
  final bool isPhoneNumber;
  final FormFieldValidator<String> validator;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final double fontSize;
  final double borderRadius;
  final Color textColor;
  final Color hintColor;
  final Color labelColor;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final GestureTapCallback? onIconPressed;
  final onTap;
  final bool obscureText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool isSendMessage;
  final bool isReadOnly;
  final bool isDate;
  final bool isTime;
  final onChanged;

  const STextFieldPassword({
    super.key,
    this.label = '',
    this.hint = '',
    required this.keyboardType,
    this.inputFormatters = const <TextInputFormatter>[],
    this.isPasswordField = false,
    this.isRequiredField = false,
    this.isPhoneNumber = false,
    required this.validator,
    required this.formKey,
    required this.controller,
    this.maxLength = 250,
    this.maxLines = 1,
    this.fontSize = 14,
    this.borderRadius = 50,
    this.textColor = ParcelColors.black,
    this.hintColor = ParcelColors.gray,
    this.labelColor = ParcelColors.gray,
    this.fillColor = ParcelColors.white,
    this.borderColor = ParcelColors.paleCyan,
    this.iconColor = ParcelColors.gray,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.obscureText = false,
    this.isSendMessage = false,
    this.isDate = false,
    this.isTime = false,
    this.isReadOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onIconPressed,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: BorderSide(
        color: borderColor,
        width: 1.0,
      ),
    );
    return TextFormField(
        onTap: onTap,
        readOnly: isReadOnly,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            fillColor: fillColor,
            counter: const Offstage(),
            prefixIcon: Icon(Icons.lock, color: iconColor),
            suffixIcon: isPasswordField
                ? IconButton(
                    padding: const EdgeInsets.only(right: 5),
                    icon: Icon(
                        !obscureText
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: iconColor),
                    onPressed: onIconPressed)
                : const SizedBox(height: 0, width: 0),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            floatingLabelBehavior: floatingLabelBehavior,
            /*labelText: isRequiredField ? '$label*' : label,*/
            floatingLabelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: ParcelColors.brandeisblue,
                fontSize: fontSize),
            hintText: isRequiredField ? '$hint*' : hint,
            labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: hintColor,
                fontSize: fontSize),
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: hintColor,
                fontSize: fontSize),
            errorStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: ParcelColors.redPigment,
                fontSize: 0),
            errorMaxLines: 2,
            border: inputBorder,
            disabledBorder: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: inputBorder,
            focusedErrorBorder: inputBorder,
            focusedBorder: inputBorder),
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            color: textColor,
            fontSize: fontSize),
        autocorrect: false,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        onSaved: (value) {
          formKey.currentState?.save();
          formKey.currentState?.validate();
        });
  }
}

class NTextFieldPassword extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool isPasswordField;
  final bool isRequiredField;
  final bool isPhoneNumber;
  final FormFieldValidator<String> validator;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final double fontSize;
  final double borderRadius;
  final Color textColor;
  final Color hintColor;
  final Color labelColor;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final GestureTapCallback? onIconPressed;
  final onTap;
  final bool obscureText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool isSendMessage;
  final bool isReadOnly;
  final bool isDate;
  final bool isTime;
  final onChanged;
  final prefixIcon;

  const NTextFieldPassword(
      {super.key,
      this.label = '',
      this.hint = '',
      required this.keyboardType,
      this.inputFormatters = const <TextInputFormatter>[],
      this.isPasswordField = false,
      this.isRequiredField = false,
      this.isPhoneNumber = false,
      required this.validator,
      required this.formKey,
      required this.controller,
      this.maxLength = 250,
      this.maxLines = 1,
      this.fontSize = 14,
      this.borderRadius = 50,
      this.textColor = ParcelColors.black,
      this.hintColor = ParcelColors.gray,
      this.labelColor = ParcelColors.gray,
      this.fillColor = ParcelColors.white,
      this.borderColor = ParcelColors.paleCyan,
      this.iconColor = ParcelColors.gray,
      this.textAlign = TextAlign.start,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.obscureText = false,
      this.isSendMessage = false,
      this.isDate = false,
      this.isTime = false,
      this.isReadOnly = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.always,
      this.onIconPressed,
      this.onTap,
      this.onChanged,
      this.prefixIcon = true});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor));
    OutlineInputBorder focussedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor));
    OutlineInputBorder errorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: borderColor));
    return TextFormField(
        onTap: onTap,
        readOnly: isReadOnly,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            fillColor: fillColor,
            counter: const Offstage(),
            prefixIcon: prefixIcon
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 7),
                    child: Icon(Icons.lock, color: iconColor),
                  )
                : null,
            suffixIcon: isPasswordField
                ? IconButton(
                    padding: const EdgeInsets.only(top: 5, bottom: 7),
                    icon: Icon(
                        !obscureText
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: iconColor),
                    onPressed: onIconPressed)
                : const SizedBox(height: 0, width: 0),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            floatingLabelBehavior: floatingLabelBehavior,
            /*labelText: isRequiredField ? '$label*' : label,*/
            floatingLabelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: ParcelColors.brandeisblue,
                fontSize: fontSize),
            hintText: isRequiredField ? '$hint*' : hint,
            labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: hintColor,
                fontSize: fontSize),
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: hintColor,
                fontSize: fontSize),
            errorStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: ParcelColors.redPigment,
                fontSize: 14),
            errorMaxLines: 2,
            border: border,
            disabledBorder: border,
            enabledBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: focussedBorder,
            focusedBorder: focussedBorder),
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400, color: textColor, fontSize: fontSize),
        autocorrect: false,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        onSaved: (value) {
          formKey.currentState?.save();
          formKey.currentState?.validate();
        });
  }
}
