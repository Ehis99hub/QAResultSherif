import 'package:flutter/material.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/typedefs.dart';

class DashboardListItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final Color bgColor;
  final Color activeColor;
  final bool isActive;
  final OnPressed onTap;
  final Key key;

  const DashboardListItem({
    @required this.leading,
    @required this.title,
    this.bgColor = appGrey,
    this.activeColor = appTeal,
    this.isActive = false,
    this.onTap,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            scaler.fontSizer.sp(30),
          ),
          color: !isActive ? bgColor : activeColor,
        ),
        padding: scaler.insets.symmetric(
          vertical: 3,
          horizontal: 3,
        ),
        margin: scaler.insets.symmetric(
          vertical: 1,
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(.5),
            2: FlexColumnWidth(9),
          },
          children: [
            TableRow(
              children: [
                leading,
                const SizedBox(),
                AppText(
                  title ?? "",
                  style: boldText.copyWith(
                    fontSize: 35,
                    color: isActive ? appWhite : appBlack,
                  ),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}