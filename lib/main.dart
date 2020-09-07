import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roavapp/pages/splash_page.dart';
import 'package:roavapp/styles/theme.dart';
import 'package:roavapp/values/routes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Hive.openBox("user_data");
  await Hive.openBox("app_data");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appThemeData(),
      home: SplashPage(),
      routes: staticRoutes,
      onGenerateRoute: dynamicRoutes,
    );
  }
}
