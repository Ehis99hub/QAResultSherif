import 'package:roavapp/values/regex.dart';

class Validators {
  static String required(String text) {
    if (text == null || text.isEmpty) {
      return "This field cannot be empty";
    }  else {
      return null;
    }
  }

  static String password(String text) {
    if (text == null ||  text.isEmpty) {
      return "Password field cannot be empty";
    } else if (!passRegEx.hasMatch(text)  || text.length < 8) {
      return "Invalid password, passwords should have at least 8 characters with at least one uppercase letter";
    } else {
      return null;
    }
  }

  static String minLength(String text, int minLength) {
    if (text == null || text.isEmpty) {
      return "This field cannot be empty";
    } else if (text.length < minLength) {
      return "This field is required to have at least $minLength characters";
    } else {
      return null;
    }
  }

  static String maxLenth(String text, int maxLength) {
    if (text.isEmpty) {
      return "This field cannot be empty";
    } else if (text.length > maxLength) {
      return "This field is required tog have at most $maxLength characters";
    } else {
      return null;
    }
  }
}