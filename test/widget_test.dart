import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roavapp/pages/dashboard/dashboard_page.dart';

import 'package:roavapp/pages/emergency/emergency_page.dart';
import 'package:roavapp/values/json.dart';
import 'package:roavapp/values/values.dart';

Widget mediaQueryHelper(Widget child) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: child));
}

void main() {
  testWidgets('Emergency page has calling... text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      mediaQueryHelper(
        EmergencyPage(),
      ),
    );

    expect(find.text('Calling...'), findsOneWidget);
    expect(find.text('07034811040'), findsOneWidget);
  });
  dasboardPageTest();
}

void dasboardPageTest() {
  testWidgets('Dashboard active page index updates',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      mediaQueryHelper(
        DashboardPage.test(),
      ),
    );

    for (final it in dashItems) {
      print(it);
      final tile = find.byKey(Key(it.route), skipOffstage: false);
      final index = dashItems.indexOf(it);
      print(tile.first);
      await tester.tap(tile.first);
      await tester.pump();

      if (index != 5) {
        expect(dashboardIndex.value, index);
      } else {
        expect(dashboardIndex.value, index - 1);
      }
    }
  });
}
