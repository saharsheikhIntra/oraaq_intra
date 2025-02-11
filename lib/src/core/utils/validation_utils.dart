import 'package:oraaq/src/core/constants/string_constants.dart';

class ValidationUtils {
  static final RegExp _emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  // static final RegExp _strongPasswordPattern = RegExp(
  //     r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$");
  static final RegExp _strongPasswordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&*()_+\-=\[\]{};:"|,.<>\/?])[A-Za-z\d!@#\$%\^&*()_+\-=\[\]{};:"|,.<>\/?]{8,}$');

  static final RegExp _numberPattern = RegExp(r'^[0-9]+$');
  static final RegExp _phoneNumberPattern = RegExp(r'^03\d{9}$');
  //CNIC regex
  static final RegExp _cnicPattern = RegExp(r'^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$');

  static String? checkEmptyField(String? value) {
    return value != null && value.trim().isNotEmpty
        ? null
        : StringConstants.checkEmptyField;
  }

  static String? checkStrongPassword(String? value) {
    return _strongPasswordPattern.hasMatch(value ?? '')
        ? null
        : StringConstants.checkStrongPassword;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    return value == originalPassword
        ? null
        : StringConstants.confirmPasswordValidation;
  }

  static String? checkCnic(String? value) {
    return _cnicPattern.hasMatch(value ?? '')
        ? null
        : "Invalid CNIC format. Example: 12345-1234567-1";
  }

static String? checkBusinessName(String? value) {
    return checkLength(value, 3, 50); // Ensure name is 3-50 characters long
  }
  static String? checkEmail(String? value) {
    return _emailPattern.hasMatch(value ?? '')
        ? null
        : StringConstants.checkEmailValidation;
  }

  static String? checkLength(
    String? value,
    int? min,
    int? max, {
    String? customeError,
  }) {
    if (min != null && max != null) {
      return value != null && value.length >= min && value.length <= max
          ? null
          : StringConstants.minMaxFieldLengthPrompt(min, max);
    } else if (min != null) {
      return (value ?? '').isNotEmpty && (value ?? '').length >= min
          ? null
          : StringConstants.minFieldLengthPrompt(min);
    } else if (max != null) {
      return (value ?? '').isNotEmpty && (value ?? '').length >= max
          ? null
          : StringConstants.maxFieldLengthPrompt(max);
    }
    return (value ?? '').isNotEmpty ? null : StringConstants.mustNotBeEmpty;
  }

  static String? checkPhoneNumber(String? value) {
    return _phoneNumberPattern.hasMatch(value ?? '')
        ? null
        : StringConstants.checkPhoneNumber;
  }

  static String? checkNumeric(String? value) {
    return _numberPattern.hasMatch(value ?? '')
        ? null
        : "This field requires numeric input";
  }

  static bool isValidEmail(String email) {
    return _emailPattern.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    return _phoneNumberPattern.hasMatch(phoneNumber);
  }

  static bool isValidPassword(String password) {
    return _strongPasswordPattern.hasMatch(password);
  }

  static bool isValidConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
