import 'package:flutter/widgets.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/http/covid_response.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/intl_formatter.dart';

class CovidStatTable extends StatelessWidget {
  final CovidData data;

  CovidStatTable({this.data});

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: appGrey,
        borderRadius: BorderRadius.circular(
          scaler.fontSizer.sp(15),
        ),
      ),
      padding: scaler.insets.symmetric(
        vertical: 3,
        horizontal: 3,
      ),
      margin: scaler.insets.only(
        bottom: 1.5,
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(4),
        },
        children: [
          TableRow(
            children: [
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(data?.country ?? ""),
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
          TableRow(
            children: [
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  "total cases:",
                  style: normalText,
                ),
              ),
              const SizedBox(),
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  AppFormatter.formatCurrencyInput((data?.cases?.total ?? 0).toString()),
                  style: normalText,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  "total deaths:",
                  style: normalText,
                ),
              ),
              const SizedBox(),
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  AppFormatter.formatCurrencyInput((data?.deaths?.total ?? 0).toString()),
                  style: normalText,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  "total recovered:",
                  style: normalText,
                ),
              ),
              const SizedBox(),
              Container(
                margin: scaler.insets.only(
                  bottom: 1,
                ),
                child: AppText(
                  AppFormatter.formatCurrencyInput((data?.cases?.recovered ?? 0).toString()),
                  style: normalText,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
