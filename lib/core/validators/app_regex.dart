abstract class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// ================= PASSWORD =================
  static bool hasLowerCase(String password) {
    return RegExp(r'(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'(?=.*\d)').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'(?=.*[@$#!%*?&])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  static bool isPhoneValid(String phone) {
    final trimmed = phone.trim();

    final internationalRegex = RegExp(r'^\+201[0-9]{9}$');

    return internationalRegex.hasMatch(trimmed);
  }

  static bool isNationalIdValid(String nationalId) {
    final trimmed = nationalId.trim();

    final regex = RegExp(r'^[0-9]{14}$');

    return regex.hasMatch(trimmed);
  }
}
