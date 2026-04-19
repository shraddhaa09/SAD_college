class Utility {
  // checks if email format is valid
  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return emailRegex.hasMatch(email);
  }

  // password must be 8+ chars, have uppercase, number, special char
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    if (!RegExp(r'[!@#\$%^&*]').hasMatch(password)) return false;
    return true;
  }
}