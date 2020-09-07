import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';

void main() {
  group('SignUp', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final name = find.byValueKey('name');
    final telephone = find.byValueKey('telephone');
    final password = find.byValueKey('password');
    final signup = find.byType('AppButton');

    var fullName = 'Sheriff Sanni';
    var phone = '09082911632';
    var pass = 'password';
    var passwordValidation =
        'Sorry the provided password is not strong enough, passwords should have at least one capital letter';

    FlutterDriver driver;
    Ozzie ozzie; //Ozzie object

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      sleep(const Duration(seconds: 5));
      ozzie = Ozzie.initWith(driver,
          groupName: 'SignUp',
          shouldTakeScreenshots: true); // Initialize the Ozzie instance
      //await Directory('screenshots').create();
    });

    test('check health', () async {
      await ozzie.profilePerformance('SignUp', () async {
        Health health = await driver.checkHealth();
        print(health.status);
        await ozzie.takeScreenshot('health');
      });
    });

    /* test("flutter drive test", () async {
      await driver.tap(writeDataFinder);
      await driver.tap(addDataFinder);
    }); */

    test('SignUp Validation', () async {
      await driver.tap(name);
      await driver.enterText(fullName);
      await driver.waitFor(find.text(fullName)); // verify fullname appears
      await ozzie.takeScreenshot('name');

      await driver.tap(telephone);
      await driver.enterText(phone);
      await driver.waitFor(find.text(phone)); // verify phone appears
      await ozzie.takeScreenshot('phone');

      await driver.tap(password);
      await driver.enterText(pass);
      await driver.waitFor(find.text(pass)); // verify password appears
      await ozzie.takeScreenshot('signup');

      await driver.tap(signup);
      await driver
          .waitFor(find.text(passwordValidation)); // verify new text appears
    });

    tearDownAll(() async {
      if (driver != null) {
        //Close the connection to the driver after the tests have completed.
        await driver.close();
      }
      await ozzie.generateHtmlReport(); //Finally generate html report
    });
  });
}
