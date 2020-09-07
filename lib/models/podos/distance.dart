class Distance {
  double distance;
  String unit;
  String smallUnit;
  int factor;
  double smallBorder;

  Distance({
    this.distance,
    this.unit,
    this.smallUnit,
    this.factor,
    this.smallBorder,
  });

  Distance.fromJson(Map json) {
    distance = json['distance'];
    unit = json['unit'];
    smallUnit = json['smallUnit'];
    factor = json['factor'];
    smallBorder = json['smallBorder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['unit'] = this.unit;
    data['smallUnit'] = this.smallUnit;
    data['factor'] = this.factor;
    data['smallBorder'] = this.smallBorder;
    return data;
  }
}
