import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';

void main() {
  group('Login', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final login = find.text('LOGIN');
    final loginHeader = find.text('Welcome to\nGreen medical clinic');
    final signupHeader =
        find.text('Please ensure to provide the correct details below');
    final telephone = find.byValueKey('telephone');
    final password = find.byValueKey('password');
    final signUpButton = find.byType('AppFlatButton');
    final loginButton = find.byType('AppButton');
    final signup = find.byType('AppButton');

    final name = find.byValueKey('name');
    var phone = '09082911632';


    var phoneNumber = '09082911632';
    var pass = 'P@ssw0';
    var error = "The provided credentials don't match any user";
    var welcome = 'Welcome, Sheriff';
    var fullName = 'Sheriff Sanni';


    FlutterDriver driver;
    Ozzie ozzie; //Ozzie object

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      sleep(const Duration(seconds: 5));
      ozzie = Ozzie.initWith(driver,
          groupName: 'Login', shouldTakeScreenshots: true);
    });

    test('Check Health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
      await ozzie.takeScreenshot('health');
    });

    test('Navigate to Login Page', () async {
      // TODO(sheriff): message, https://URL-to-issue.: Extract this to a function
      await driver.tap(login);
      await driver.waitFor(loginHeader);
      await ozzie.takeScreenshot('login');
    });

    test('Invalid User', () async {
      await driver.waitFor(loginHeader);

      await driver.tap(telephone);
      await driver.enterText('09082911631');
      await driver.waitFor(find.text('09082911631'));

      await driver.tap(password);
      await driver.enterText(pass);

      await driver.tap(loginButton);
      await driver.waitFor(loginHeader);
    });

    test('Invalid Password', () async {
      await driver.waitFor(loginHeader);

      await driver.tap(telephone);
      await driver.enterText(phoneNumber);
      await driver.waitFor(find.text(phoneNumber));

      await driver.tap(password);
      await driver.enterText('pass');

      await driver.tap(loginButton);
     await driver.waitFor(loginHeader);
    });

    test('Successful Login', () async {
      await driver.tap(telephone);
      await driver.enterText(phoneNumber);
      await driver.waitFor(find.text(phoneNumber));

      await driver.tap(password);
      await driver.enterText(pass);
      await driver.waitFor(find.text(pass));

      await driver.tap(loginButton);
      await driver.waitFor(find.text(welcome));
    });

    test('Login Via Signup', () async {
      await driver.tap(signUpButton);
      await driver.waitFor(signupHeader);

      ///
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

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
      await ozzie.generateHtmlReport();
    });
  });
}
