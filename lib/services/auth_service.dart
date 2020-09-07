import 'package:hive/hive.dart';
import 'package:roavapp/models/podos/login_response.dart';
import 'package:roavapp/models/podos/service_response.dart';
import 'package:roavapp/values/values.dart';

class AuthService {
  final db = Hive.box("user_data");
  final appDb = Hive.box("app_data");

  ServiceResponse signup(String name, String telephone, String password) {
    if (appDb.containsKey(telephone)) {
      return ServiceResponse(
        message: "A user already exists with this phone number",
        isSuccessful: false,
      );
    }
    appDb.put(
      "$telephone",
      {
        "telephone": telephone,
        "password": password,
        "name": name,
      },
    );
    _setUserData(
      {
        "telephone": telephone,
        "password": password,
        "name": name,
      },
    );
    return ServiceResponse(
      message: "Yaay your signup was succesful",
      isSuccessful: true,
    );
  }

  _setUserData(Map user) {
    try {
      db.put("currentUser", {
        "message": "Yaay successful login",
        "isSuccessful": true,
        "name": user["name"],
        "telephone": user["telephone"]
      });
      db.put("isLoggedIn", true);
      dashboardIndex.value = null;
    } catch (_) {}
  }

  set isPreviousUser(bool val) {
    appDb.put("isPreviousUser", val);
  }

  LoginResponse login(String telephone, String password) {
    if (appDb.containsKey(telephone)) {
      final user = appDb.get(
        telephone,
        defaultValue: null,
      );
      if (user != null && user is Map && user["password"] == password) {
        _setUserData(user);
        return LoginResponse(
          message: "Yaay successful login",
          isSuccessful: true,
          name: user["name"],
          telephone: user["telephone"],
        );
      }
      return LoginResponse(
        message: "The provided credentials don't match any user",
        isSuccessful: false,
      );
    } else {
      return LoginResponse(
        message: "No user matches the provided telephone",
        isSuccessful: false,
      );
    }
  }

  void logout() {
    db.delete("currentUser");
    db.put("isLoggedIn", false);
  }
}
