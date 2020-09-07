import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/podos/physician.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/typedefs.dart';

class PhysioListItem extends StatelessWidget {
  final Physician physician;
  final Color bgColor;
  final OnPressed onTap;

  const PhysioListItem({
    @required this.physician,
    this.bgColor = appGrey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            scaler.fontSizer.sp(30),
          ),
          color: bgColor,
        ),
        padding: scaler.insets.symmetric(
          vertical: 1.5,
          horizontal: 2.5,
        ),
        margin: scaler.insets.symmetric(
          vertical: .6,
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(.2),
            2: FlexColumnWidth(7),
            3: FlexColumnWidth(.3),
            4: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              children: [
                Hero(
                  tag: physician.picture,
                  child: Container(
                    height: scaler.fontSizer.sp(140),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          physician.picture,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                        scaler.fontSizer.sp(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      physician.name ?? "",
                      style: boldText.copyWith(
                        fontSize: 35,
                        color: appBlack,
                      ),
                    ),
                    const AppSizedBox(height: .5),
                    AppText(
                      physician.specialty ?? "",
                      style: normalText.copyWith(
                        fontSize: 25,
                        color: appBlack.withOpacity(.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints.tightFor(
                      height: scaler.fontSizer.sp(90),
                      width: scaler.fontSizer.sp(85),
                    ),
                    decoration: BoxDecoration(
                      color: appTeal,
                      borderRadius: BorderRadius.circular(
                        scaler.fontSizer.sp(20),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: appWhite,
                        size: scaler.fontSizer.sp(30),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
