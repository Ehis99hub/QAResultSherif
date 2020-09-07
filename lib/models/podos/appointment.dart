class Appointment {
  String date;
  String id;
  num from;
  num to;
  String physician;

  Appointment({this.date, this.from, this.to, this.physician, this.id,});

  Appointment.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    from = json['from'];
    to = json['to'];
    id = json['id'];
    physician = json['physician'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['from'] = this.from;
    data['to'] = this.to;
    data['id'] = this.id;
    data['physician'] = this.physician;
    return data;
  }
}
