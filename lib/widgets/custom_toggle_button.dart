import 'package:flutter/material.dart';
import 'package:project/widgets/text_widget.dart' as custom_text_widget; // Add a prefix to the import

class CustomToggleSwitch extends StatelessWidget {
  final bool isOn;
  final Function(bool) onToggle;
  final String labelOn;
  final String labelOff;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomToggleSwitch({
    Key? key,
    required this.isOn,
    required this.onToggle,
    required this.labelOn,
    required this.labelOff,
    this.fontSize = 12.0,
    this.fontWeight = FontWeight.w600,
    this.textColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isOn
              ? custom_text_widget.TextWidget(  // Use the prefixed class
                  label: labelOn,
                  key: ValueKey('On'),  // This is not a constant value
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  textColor: textColor,
                )
              : custom_text_widget.TextWidget(  // Use the prefixed class
                  label: labelOff,
                  key: ValueKey('Off'),  // This is not a constant value
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  textColor: textColor,
                ),
        ),
        Transform.scale(
          scale: 0.8, // Make the switch smaller
          child: Switch(
            value: isOn,
            onChanged: onToggle,
            activeColor: textColor,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const TextWidget({
    Key? key,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
