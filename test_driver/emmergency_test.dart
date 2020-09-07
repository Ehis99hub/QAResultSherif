import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';

void main() {
  group('Emmergency', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final name = find.byValueKey('name');
    final telephone = find.byValueKey('telephone');
    final password = find.byValueKey('password');
    final signup = find.byType('AppButton');
    final signupHeader =
        find.text('Please ensure to provide the correct details below');
    final emergency = find.text('Emergency');

    var fullName = 'Sheriff Sanni';
    var welcome = 'Welcome, Sheriff';
    final signUpButton = find.byType('AppFlatButton');

    var phone = '09082911632';
    var pass = 'P@ssw0';
    var passwordValidation =
        'Sorry the provided password is not strong enough, passwords should have at least one capital letter';

    FlutterDriver driver;
    Ozzie ozzie; //Ozzie object

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      sleep(const Duration(seconds: 5));
      ozzie = Ozzie.initWith(driver,
          groupName: 'Emmergency',
          shouldTakeScreenshots: true); // Initialize the Ozzie instance
      //await Directory('screenshots').create();
    });

    test('check health', () async {
      //await ozzie.profilePerformance('Emmergency', () async {
      Health health = await driver.checkHealth();
      print(health.status);
      await ozzie.takeScreenshot('health');
      //});
    });

    test('Login Via Signup', () async {
      //TODO: Loook into why i need to login via signup

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
      await driver.waitFor(find.text(welcome));

      await ozzie.takeScreenshot('loggedIn');
    });

    test('Navigate to Emergency Page', () async {
      await driver.tap(emergency);
      await driver.waitFor(find.text('07034811040'));
      await driver.waitFor(find.text('Calling...'));
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
