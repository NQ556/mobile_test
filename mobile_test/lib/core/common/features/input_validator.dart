class InputValidator {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}$');
    return passwordRegex.hasMatch(password);
  }
}
