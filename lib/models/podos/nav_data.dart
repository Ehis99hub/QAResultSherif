import 'package:geolocator/geolocator.dart' show Position;

class NavData {
  Position position;
  String distance;

  NavData({this.position, this.distance});
}
