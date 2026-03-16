import 'package:my_first_project/configurations.dart';

class Utility {

  static bool validateEmail(String text) {
    return RegExp(
      r"^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,4}){1,2}$",
    ).hasMatch(text);
  }

  static bool validateCredentials({required String userId, String? password}) {

    for (var entry in Configurations.credentials) {
      if (entry['userid'] == userId &&
          (password == null || entry['password'] == password)) {
        return true;
      }
    }

    return false;
  }

  static bool validateLowerCase(String text) {
    return RegExp(r"[a-z]").hasMatch(text);
  }

  static bool validateUpperCase(String text) {
    return RegExp(r"[A-Z]").hasMatch(text);
  }

  static bool validateDigit(String text) {
    return RegExp(r"[0-9]").hasMatch(text);
  }

  static bool validateSymbol(String text) {
    return RegExp(r"[!@#$^_]").hasMatch(text);
  }
}