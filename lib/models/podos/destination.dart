import 'package:flutter/cupertino.dart';

class Destination{
  final String name;
  final double lat;
  final double long;
  final String picture;

  const Destination({
    @required this.name,
    @required this.long,
    @required this.lat,
    this.picture,
  });
}
