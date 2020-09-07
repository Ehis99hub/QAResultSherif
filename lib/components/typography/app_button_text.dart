import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roavapp/components/typography/app_text.dart';

class ButtonText extends StatelessWidget {
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String text;

  ButtonText(
    this.text, {
    this.fontSize = 40,
    this.textColor,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    final btnTheme = Theme.of(context).textTheme.button;
    return AppText(
      text ?? "Tap",
      style: btnTheme.copyWith(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}
