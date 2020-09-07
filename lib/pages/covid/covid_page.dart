import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/indicators/app_spinner.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/fragments/tables/covid_stat_table.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/http/covid_response.dart';
import 'package:roavapp/state/covid_state.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';

class CovidPage extends StatelessWidget {
  final model = CovidState.instance;

  CovidPage();

  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: scaler.insets.symmetric(
            horizontal: 7,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const AppSizedBox(height: 2),
              AppBackButton.plain(),
              const AppSizedBox(height: 4),
              AppText(
                "Covid 19 news\nand updates",
                style: boldText.copyWith(
                  fontSize: 50,
                ),
              ),
              const AppSizedBox(height: 2),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: model.statsRef,
                  builder: (
                    context,
                    Future<Map<String, List<CovidData>>> future,
                    _,
                  ) {
                    return FutureBuilder(
                      future: future,
                      builder: (
                        context,
                        AsyncSnapshot<Map<String, List<CovidData>>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: const AppSpinner(),
                          );
                        } else if (snapshot.hasError &&
                            (!snapshot.hasData || snapshot.data.isEmpty)) {
                          return Container(
                            padding: scaler.insets.symmetric(
                              vertical: 2,
                              horizontal: 7,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                AppText(
                                  "We could not fetch statistics at this time due to an error",
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
                                    text: "Retry",
                                    isDense: true,
                                    onPressed: () {
                                      model.statsRef = ValueNotifier(
                                        model.getStats(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            child: CustomScrollView(
                              slivers: snapshot.data.keys.map(
                                (key) {
                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, idx) {
                                        if (idx == 0) {
                                          return Container(
                                            child: AppText(
                                              key,
                                              style: boldText.copyWith(
                                                color: appBlack.withOpacity(.5),
                                                fontSize: 60,
                                              ),
                                            ),
                                            margin: scaler.insets.symmetric(
                                              vertical: 2,
                                            ),
                                          );
                                        }
                                        return CovidStatTable(
                                          data: snapshot.data[key][idx - 1],
                                        );
                                      },
                                      childCount: snapshot.data[key].length + 1,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            onRefresh: () async {
                              model.statsRef = ValueNotifier(
                                model.getStats(),
                              );
                            },
                          );
                        }
                      },
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
