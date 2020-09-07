import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/utils/dimensions.dart';

class AppSpinner extends StatelessWidget {
  final Brightness brightness;
  const AppSpinner({this.brightness = Brightness.light});

  @override
  Widget build(BuildContext context) {
    final sizer = AppScaleUtil(context).sizer;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: sizer.setHeight(5),
          width: sizer.setHeight(5),
        ),
        child: Theme.of(context).platform == TargetPlatform.iOS
            ? CupertinoTheme(
                data:
                    CupertinoTheme.of(context).copyWith(brightness: brightness),
                child: CupertinoActivityIndicator(
                  radius: sizer.setWidth(4),
                ),
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(appTeal),
              ),
      ),
    );
  }
}
