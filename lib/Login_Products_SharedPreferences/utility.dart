import 'configurations.dart';

class Utility {
  static bool validateEmail(String text) {
    return RegExp(
      r"^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,4}){1,2}$",
    ).hasMatch(text);
  }

  static bool validateCredentials({required String userId, String? password}) {
    for (var cred in Configurations.credentials) {
      if (cred['userid'] == userId && cred['password'] == password) {
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
    // Matches special characters including those from your screenshot
    return RegExp(r"[!@#\$%^&*(),.?\':{}|<>]").hasMatch(text);
  }

  static bool isPasswordStrong(String text) {
    return text.length >= 8 &&
        validateLowerCase(text) &&
        validateUpperCase(text) &&
        validateDigit(text) &&
        validateSymbol(text);
  }
}