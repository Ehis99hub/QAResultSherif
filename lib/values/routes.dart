import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'package:roavapp/pages/auth/login_page.dart';
import 'package:roavapp/pages/auth/signup_page.dart';
import 'package:roavapp/pages/covid/covid_page.dart';
import 'package:roavapp/pages/dashboard/dashboard_page.dart';
import 'package:roavapp/pages/emergency/emergency_page.dart';
import 'package:roavapp/pages/map/map_page.dart';
import 'package:roavapp/pages/physicians/physician_detail_page.dart';
import 'package:roavapp/pages/physicians/physician_list_page.dart';
import 'package:roavapp/pages/physicians/physician_schedule_page.dart';
import 'package:roavapp/pages/success/success_page.dart';

final Map<String, Widget Function(BuildContext)> staticRoutes = {
  "/signup": (BuildContext context) => const SignupPage(),
  "/login": (BuildContext context) => const LoginPage(),
  "/dashboard": (BuildContext context) => const DashboardPage(),
  "/emergency": (BuildContext context) => const EmergencyPage(),
  "/covid": (BuildContext context) => CovidPage(),
  "/success": (BuildContext context) => const SuccessPage(),
  "/doctors": (BuildContext context) => const PhysicianListPage(),
  "/map": (BuildContext context) => const MapPage(),
};

Route<dynamic> dynamicRoutes(RouteSettings settings) {
  switch (settings.name) {
    case "/doctors/detail":
      return MaterialPageRoute(
        builder: (context) {
          return PhysioDetailPage(physio: settings.arguments);
        },
      );
    case "doctors/schedule":
      return MaterialPageRoute(
        builder: (context) {
          return PhysioSchedulePage(physio: settings.arguments);
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return const SuccessPage();
        },
      );
  }
}
