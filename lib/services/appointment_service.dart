import 'package:hive/hive.dart';
import 'package:roavapp/models/podos/appointment.dart';
import 'package:roavapp/models/podos/service_response.dart';

class AppointmentService {
  final db = Hive.box("app_data");

  ServiceResponse createAppointment(Appointment appointment) {
    if (db.containsKey(appointment.id)) {
      return ServiceResponse(
        isSuccessful: false,
        message: "Sorry the doctor is already booked at this time and date",
      );
    }
    db.put(appointment.id, appointment.toJson());
    return ServiceResponse(
      isSuccessful: true,
      message: "Yaay your booking was successful",
    );
  }
}
