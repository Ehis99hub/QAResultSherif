import 'package:flutter/foundation.dart' show required;

class DashboardItem {
  final String title;
  final String icon;
  final String route;

  const DashboardItem({
    @required this.title,
    @required this.icon,
    @required this.route,
  });
}