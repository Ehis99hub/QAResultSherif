import 'package:flutter/material.dart';
import 'package:roavapp/utils/dimensions.dart';

class AppText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final Locale locale;
  final StrutStyle strutStyle;
  final bool softWrap;
  final int maxLines;
  final TextDirection textDirection;
  final TextOverflow overflow;

  AppText(
    this.data, {
    this.style,
    this.textAlign,
    this.locale,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.strutStyle,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final _style = style != null ? style : Theme.of(context).textTheme.bodyText1;
    final _fontSize = style != null ? _style.fontSize ?? 35.0 : 35.0;
    final scaler = AppScaleUtil(context);
    return Text(
      data ?? "",
      style: _style.copyWith(
        fontSize: scaler.fontSizer.sp(_fontSize),
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}
