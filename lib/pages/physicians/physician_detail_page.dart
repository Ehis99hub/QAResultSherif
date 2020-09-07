import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/podos/physician.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/helpers.dart';
import 'package:roavapp/values/images.dart';
import 'package:roavapp/values/strings.dart';

class PhysioDetailPage extends StatelessWidget {
  final Physician physio;

  const PhysioDetailPage({
    @required this.physio,
  });

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(
                    color: appGrey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        scaler.fontSizer.sp(30),
                      ),
                      bottomRight: Radius.circular(
                        scaler.fontSizer.sp(30),
                      ),
                    ),
                  ),
                  padding: scaler.insets.fromLTRB(5, 2, 5, 2.5),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBackButton.plain(
                          bgColor: appTransparent,
                        ),
                        const AppSizedBox(height: 5),
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FlexColumnWidth(2.7),
                            1: FlexColumnWidth(8),
                          },
                          children: [
                            TableRow(
                              children: [
                                Hero(
                                  tag: physio.picture,
                                  child: Container(
                                    height: scaler.fontSizer.sp(230),
                                    decoration: BoxDecoration(
                                      color: appWhite,
                                      border: Border.all(
                                        color: appBlack.withOpacity(.1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        scaler.fontSizer.sp(20),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(physio.picture),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: scaler.insets.only(left: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AppText(
                                        physio.name,
                                        style: boldText.copyWith(fontSize: 50),
                                      ),
                                      const AppSizedBox(height: 1),
                                      AppText(
                                        physio.specialty,
                                        style: normalText.copyWith(
                                            color: appBlack.withOpacity(.5)),
                                      ),
                                      const AppSizedBox(height: .5),
                                      AppText(
                                        "${physio?.experience ?? 0} years of experience",
                                        style: normalText.copyWith(
                                          color: appBlack.withOpacity(.5),
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverPadding(
            padding: scaler.insets.symmetric(
              vertical: 3,
              horizontal: 5,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    constraints: BoxConstraints.tightFor(
                      height: scaler.sizer.setHeight(5),
                    ),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FlexColumnWidth(3.5),
                        1: FlexColumnWidth(6)
                      },
                      children: [
                        TableRow(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: <Widget>[
                                Positioned(
                                  left: scaler.fontSizer.sp(150),
                                  child: Container(
                                    height: scaler.fontSizer.sp(70),
                                    width: scaler.fontSizer.sp(70),
                                    decoration: BoxDecoration(
                                      color: appBlack,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.voucher4),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: scaler.fontSizer.sp(100),
                                  child: Container(
                                    height: scaler.fontSizer.sp(70),
                                    width: scaler.fontSizer.sp(70),
                                    decoration: BoxDecoration(
                                      color: appBlack,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.voucher3),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: scaler.fontSizer.sp(50),
                                  child: Container(
                                    height: scaler.fontSizer.sp(70),
                                    width: scaler.fontSizer.sp(70),
                                    decoration: BoxDecoration(
                                      color: appBlack,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.voucher2),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    height: scaler.fontSizer.sp(70),
                                    width: scaler.fontSizer.sp(70),
                                    decoration: BoxDecoration(
                                      color: appBlack,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(AppImages.voucher1),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: scaler.fontSizer.sp(205),
                                  child: Container(
                                    height: scaler.fontSizer.sp(70),
                                    width: scaler.fontSizer.sp(70),
                                    decoration: BoxDecoration(
                                      color: appGray.withOpacity(.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: AppText(
                                        "+14",
                                        textAlign: TextAlign.center,
                                        style: boldText.copyWith(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppText(
                              "Vouched by 18 patients",
                              style: normalText.copyWith(
                                color: appBlack.withOpacity(.5),
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const AppSizedBox(height: 3),
                  AppText(
                    "Working Time",
                    style: mediumText.copyWith(
                      color: appBlack.withOpacity(.3),
                      fontSize: 30,
                    ),
                  ),
                  const AppSizedBox(height: 1),
                  AppText(
                    "${dayFromNum(physio?.schedule?.weekStart)} - ${dayFromNum(physio?.schedule?.weekEnd)}  ${hourFromNum(physio?.schedule?.dayStart)} - ${hourFromNum(physio?.schedule?.dayEnd)}",
                    style: normalText,
                  ),
                  const AppSizedBox(height: 3),
                  AppText(
                    "Education",
                    style: mediumText.copyWith(
                      color: appBlack.withOpacity(.3),
                      fontSize: 30,
                    ),
                  ),
                  const AppSizedBox(height: .5),
                  for (final edu in physio.education)
                    Container(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        spacing: scaler.sizer.setWidth(1),
                        children: <Widget>[
                          AppText(
                            bullet,
                            style: TextStyle(color: appTeal),
                          ),
                          AppText(
                            "${edu.discipline} degree at ${edu.institution} - ${edu.graduated}",
                            style: normalText,
                          ),
                        ],
                      ),
                      margin: scaler.insets.only(top: .5),
                    ),
                  const AppSizedBox(height: 3),
                  AppText(
                    "Biography",
                    style: mediumText.copyWith(
                      color: appBlack.withOpacity(.3),
                      fontSize: 30,
                    ),
                  ),
                  const AppSizedBox(height: 1),
                  AppText(
                    physio.bio,
                    style: normalText.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints.tightFor(
          width: scaler.sizer.width,
          height: scaler.sizer.setHeight(11.8),
        ),
        padding: scaler.insets.fromLTRB(5, 1.5, 5, 4),
        child: AppButton(
          text: "Book an appointment",
          onPressed: () {
            Navigator.of(context).pushNamed(
              "doctors/schedule",
              arguments: physio,
            );
          },
          isBold: true,
        ),
        decoration: BoxDecoration(
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: appBlack.withOpacity(.08),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, -3),
            )
          ],
        ),
      ),
    );
  }
}
