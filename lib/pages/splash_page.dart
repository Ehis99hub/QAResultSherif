import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';

class SplashPage extends StatelessWidget with WidgetsBindingObserver {
  final db = Hive.box("user_data");
  final db2 = Hive.box("app_data");

  void _routingHandler(BuildContext context) {
    final isPreviousUser = db2.get("isPreviousUser", defaultValue: false);
    if (isPreviousUser) {
      final isLoggedIn = db.get("isLoggedIn", defaultValue: false);
      if (!isLoggedIn) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (_) => false,
        );
        return;
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/dashboard',
          (_) => false,
        );
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/signup',
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timing) {
        Timer(
          Duration(seconds: 1),
          () {
            _routingHandler(context);
          },
        );
      },
    );
    final scaler = AppScaleUtil(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: AppText(
            "GREENMEDICAL",
            style: boldText.copyWith(
              color: appTeal,
              fontSize: 60,
            ),
          ),
        ),
        padding: scaler.insets.symmetric(
          horizontal: 5,
        ),
      ),
    );
  }
}
