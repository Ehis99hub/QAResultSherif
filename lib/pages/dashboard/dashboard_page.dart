import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roavapp/components/fragments/list_items/dashboard_list_item.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/components/typography/name_text.dart';
import 'package:roavapp/services/auth_service.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/helpers.dart';
import 'package:roavapp/utils/snacks.dart';
import 'package:roavapp/values/json.dart';
import 'package:roavapp/values/values.dart';

class DashboardPage extends StatelessWidget {
  final bool _forTest;

  const DashboardPage() : _forTest = false;

  const DashboardPage.test() : _forTest = true;

  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            padding: scaler.insets.symmetric(
              vertical: 4,
              horizontal: 7,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _forTest ? AppText("Dashboard") : NameText(),
                    IconButton(
                      icon: Icon(
                        Icons.settings_power,
                        color: appBlack,
                      ),
                      onPressed: () {
                        AuthService().logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/login",
                          (route) => false,
                        );
                      },
                    )
                  ],
                ),
                const AppSizedBox(height: 4),
                for (final item in dashItems)
                  ValueListenableBuilder(
                    valueListenable: dashboardIndex,
                    builder: (context, int activeIndex, _) {
                      return DashboardListItem(
                        key: Key(item.route),
                        leading: SvgPicture.asset(
                          item.icon,
                          height: scaler.fontSizer.sp(90),
                          width: scaler.fontSizer.sp(90),
                        ),
                        title: item.title,
                        isActive: item.title == "Discharged" ||
                            activeIndex == dashItems.indexOf(item),
                        activeColor:
                            item.title == "Discharged" ? appOrange : appTeal,
                        onTap: () async {
                          if (item.route != "/discharges") {
                            if (!_forTest) {
                              if (item.route == "/emergency") {
                                emergencyCallHandler(context);
                              }
                              if (item.route == "/map") {
                                final doRoute = await checkLocationPermission();
                                if (!doRoute) {
                                  return showSnack(
                                    context: context,
                                    message:
                                        "You cannot leverage the directions feature if you do not grant us the needed permissions",
                                  );
                                }
                              }
                              Navigator.of(context).pushNamed(item.route);
                            }
                            dashboardIndex.value = dashItems.indexOf(item);
                          }
                        },
                      );
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
