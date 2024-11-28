import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool isPoppins;
  final bool isNunitoSans;
  final bool isRoboto;
  final bool isMontserrat;
  final bool isUnderLine;
  final int maxlines;
  

  const TextWidget(
      {super.key,
        this.label = '',
        this.textColor = ParcelColors.black,
        this.fontSize = 16,
        this.fontWeight = FontWeight.w500,
        this.textAlign = TextAlign.start,
        this.isPoppins = false,
        this.isNunitoSans = false,
        this.isUnderLine = false,
        this.isRoboto = false,
        this.isMontserrat = false,
        this.maxlines = 20})
     ;

  @override
  Widget build(BuildContext context) {
    return Text(label,
        overflow: TextOverflow.ellipsis,
        maxLines: maxlines,
        textAlign: textAlign,
        style: isPoppins
            ? GoogleFonts.poppins(
            decoration: isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight)
            : isRoboto
            ? GoogleFonts.montserrat(
            decoration: isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight)
            : isNunitoSans
            ? GoogleFonts.nunitoSans(
            decoration: isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight)
            : isMontserrat
            ? GoogleFonts.montserrat(
            decoration: isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight)
            : GoogleFonts.montserrat(
            decoration: isUnderLine
                ? TextDecoration.underline
                : TextDecoration.none,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight));
  }
}




// class TextWidget extends StatelessWidget {
//   final String label;
//   final TextAlign? textAlign;
//   final Color? textColor;
//   final double? fontSize;
//   final FontWeight? fontWeight;

//   const TextWidget({
//     Key? key,
//     required this.label,
//     this.textAlign,
//     this.textColor,
//     this.fontSize,
//     this.fontWeight,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       textAlign: textAlign,
//       style: TextStyle(
//         color: textColor ?? Colors.black, // Default to black if not provided
//         fontSize: fontSize ?? 14.0, // Default font size
//         fontWeight: fontWeight ?? FontWeight.normal, // Default font weight
//       ),
//     );
//   }
// }
