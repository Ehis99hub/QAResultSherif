import 'dart:math';
import 'dart:core';

import 'package:roavapp/models/podos/coordinates.dart';
import 'package:roavapp/models/podos/distance.dart';

double toRad(degree) {
  return degree * pi / 180;
}

String humanizeDistance(
  Coordinates pointA,
  Coordinates pointB, {
  locale = "en-US",
  unitSystem = "metric",
}) {
  final deltaLatitude = toRad((pointA.latitude - pointB.latitude).abs());
  final deltaLongitude = toRad((pointA.longitude - pointB.longitude).abs());

  final a = pow(sin(deltaLatitude / 2), 2) +
      pow(sin(deltaLongitude / 2), 2) *
          cos(toRad(pointA.latitude)) *
          cos(toRad(pointB.latitude));

  final hav = 2 * atan2(sqrt(a), sqrt(1 - a));

  final distance = unitSystem == "metric" ? hav * 6373 : hav * 3960;
  return parseDistance(distance);
}

String parseDistance(
  double distance, {
  locale = "en-US",
  unitSystem = "metric",
  isRaw = false,
}) {
  if (isRaw) {
    distance = unitSystem == "metric" ? distance / 1000 : distance / 1760;
  }
  final result = Distance(
      distance: distance ?? 0,
      unit: unitSystem == "metric" ? "km" : "mi",
      smallUnit: unitSystem == "metric" ? "meters" : "yards",
      factor: unitSystem == "metric" ? 1000 : 1760,
      smallBorder: unitSystem == "metric" ? 0.9 : 0.5);

  if (result.distance < result.smallBorder) {
    distance = result.distance * result.factor;
    if (distance <= 20) {
      return "within walking distance";
    } else {
      distance = distance / 50 * 50.0;
      return "${distance.toStringAsFixed(2)} ${result.smallUnit} away";
    }
  } else {
    return "${result.distance.toStringAsFixed(2)} ${result.unit} away";
  }
}
