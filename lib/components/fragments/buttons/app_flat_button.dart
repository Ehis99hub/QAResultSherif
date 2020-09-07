import 'package:flutter/material.dart';
import 'package:roavapp/components/typography/app_button_text.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/typedefs.dart';

class AppFlatButton extends StatelessWidget {
  final OnPressed onPressed;
  final Color textColor;
  final String text;
  final Widget child;
  final double padding;

  AppFlatButton({
    this.text,
    this.child,
    @required this.onPressed,
    this.textColor = appBlack,
    this.padding = 1,
  }) {
    if (text != null && child != null) {
      throw "Only provide one of text or child";
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return FlatButton(
      color: appTransparent,
      padding: scaler.insets.symmetric(vertical: padding),
      child: child != null
          ? child
          : ButtonText(
              text,
              textColor: textColor,
            ),
      onPressed: onPressed,
    );
  }
}
