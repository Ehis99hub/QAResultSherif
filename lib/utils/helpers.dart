import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roavapp/values/json.dart';
import 'package:url_launcher/url_launcher.dart';

String dayFromNum(num day, [bool getLong = false]) {
  try {
    final key = getLong ? "long" : "short";
    return days[day - 1][key] ?? "Sun";
  } catch (_) {
    return "Sun";
  }
}

String hourFromNum(num hour) {
  try {
    final durationString =
        (Duration(hours: hour).toString().split(".")[0] ?? "00:00:00")
            .split(":");
    return "${durationString[0]}:${durationString[1]}";
  } catch (_) {
    return "00:00";
  }
}

emergencyCallHandler(BuildContext context) {
  try {
    launch("tel:07034811040");
  } catch (_) {}
}

Future<bool> checkLocationPermission() async {
  try {
    final geoStatus = await Permission.location.status;
    if (geoStatus.isGranted) {
      return true;
    } else if (geoStatus.isPermanentlyDenied) {
      return false;
    } else {
      final newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  } catch (_) {
    return false;
  }
}
