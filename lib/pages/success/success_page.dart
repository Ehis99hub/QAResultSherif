import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/values/images.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage();

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                AppSvgs.success,
                width: scaler.fontSizer.sp(250),
              ),
              const AppSizedBox(height: 1.5),
              AppText(
                "Successful",
                style: boldText.copyWith(
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              const AppSizedBox(height: 1.5),
              Padding(
                padding: scaler.insets.symmetric(
                  horizontal: 20,
                ),
                child: AppButton(
                  text: "Done",
                  isDense: true,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      "/dashboard",
                      (_) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
