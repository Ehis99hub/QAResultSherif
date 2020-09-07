import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage();

  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: scaler.insets.symmetric(
            vertical: 2,
            horizontal: 7,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const AppSizedBox(height: 20),
              AppText(
                "Calling...",
                style: mediumText.copyWith(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              const AppSizedBox(height: 1),
              AppText(
                "07034811040",
                style: boldText.copyWith(
                  fontSize: 45,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
