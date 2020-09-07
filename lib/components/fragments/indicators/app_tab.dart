import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/typedefs.dart';

class AppTab extends StatelessWidget {
  final bool isActive;
  final String text;
  final OnPressed onTap;

  AppTab({
    @required this.isActive,
    @required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return InkWell(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        margin: scaler.insets.symmetric(horizontal: 2),
        padding: scaler.insets.fromLTRB(1, 0, 1, .5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: scaler.fontSizer.sp(5),
              color: isActive ? appTeal : appTransparent,
            ),
          ),
        ),
        child: AppText(
          text,
          textAlign: TextAlign.center,
          style: boldText.copyWith(
            fontSize: 32,
            color: isActive ? appBlack : appBlack.withOpacity(.5),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
