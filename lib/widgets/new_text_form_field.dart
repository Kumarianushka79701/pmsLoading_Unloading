import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/utils/colors.dart';

class ATextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool isEditedField;
  final bool showCloseIcon;
  final bool isRequiredField;
  final EdgeInsets contentPadding;
  final FormFieldValidator<String> validator;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final double fontSize;
  final double iconSize;
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
  final GestureTapCallback? onTap;
  final bool obscureText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool isReadOnly;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isSuffixIcon;
  final FocusNode? focusNode;

  const ATextField(
      {Key? key,
      this.label = '',
      this.hint = '',
      required this.keyboardType,
      this.inputFormatters = const <TextInputFormatter>[],
      this.isEditedField = false,
      this.showCloseIcon = false,
      this.isRequiredField = false,
      this.contentPadding = const EdgeInsets.all(15),
      required this.validator,
      required this.formKey,
      required this.controller,
      this.maxLength = 250,
      this.prefixIcon,
      this.isSuffixIcon,
      this.maxLines = 1,
      this.fontSize = 14,
      this.iconSize = 30,
      this.borderRadius = 8,
      this.textColor = ParcelColors.outerspace,
      this.hintColor = ParcelColors.gray,
      this.labelColor = ParcelColors.brandeisblue,
      this.fillColor = ParcelColors.white,
      this.borderColor = ParcelColors.paleCyan,
      this.iconColor = ParcelColors.brandeisblue,
      this.textAlign = TextAlign.start,
      this.fontWeight = FontWeight.w700,
      this.fontStyle = FontStyle.normal,
      this.obscureText = false,
      this.isReadOnly = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.always,
      this.onIconPressed,
      this.suffixIcon,
      this.onTap,
      this.iconData,
      this.onChanged,
      this.focusNode});

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
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: fillColor,
            counter: const Offstage(),
            suffixIcon: isEditedField
                ? IconButton(
                    icon: Icon(
                      iconData ?? Icons.border_color,
                      color: iconColor,
                      size: iconSize,
                    ),
                    onPressed: onIconPressed)
                : showCloseIcon
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_outlined,
                          color: ParcelColors.black,
                          size: 15,
                        ),
                        onPressed: onIconPressed)
                    : (isSuffixIcon ?? false)
                        ? suffixIcon
                        : null,
            isDense: true,
            contentPadding: contentPadding,
            floatingLabelBehavior: floatingLabelBehavior,
            labelText: isRequiredField ? '$label*' : label,
            hintText: isRequiredField ? '$hint*' : hint,
            labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: labelColor,
                fontSize: fontSize),
            hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: hintColor,
                fontSize: fontSize),
            errorStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal, color: ParcelColors.redPigment),
            errorMaxLines: 2,
            border: border,
            disabledBorder: border,
            enabledBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: focussedBorder,
            focusedBorder: focussedBorder),
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700, color: textColor, fontSize: fontSize),
        autocorrect: false,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        focusNode: focusNode,
        onSaved: (value) {
          formKey.currentState?.save();
          formKey.currentState?.validate();
        });
  }
}
