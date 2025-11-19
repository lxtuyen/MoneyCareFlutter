class AppValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit.';
    }
    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Last name is required.";
    }
    final nameRegExp = RegExp(r"^[a-zA-ZÀ-ỹ\s]+$");

    if (!nameRegExp.hasMatch(value)) {
      return 'Invalid last name. Last name must contain only letters.';
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "First name is required.";
    }
    final nameRegExp = RegExp(r"^[a-zA-ZÀ-ỹ\s]+$");

    if (!nameRegExp.hasMatch(value)) {
      return 'Invalid first name. First name must contain only letters.';
    }
    return null;
  }

  static String? validateBirthDate(int? day, int? month, int? year) {
    if (day == null || month == null || year == null) {
      return 'Please select full date of birth.';
    }
    if (year > DateTime.now().year || year < 1950) {
      return 'Invalid year of birth.';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên quỹ';
    }

    return null;
  }

  static String? validatePercentage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nhập %';
    }
    final numVal = int.tryParse(value);
    if (numVal == null || numVal < 0 || numVal > 100) {
      return 'Phải từ 0-100';
    }
    return null;
  }

  static String? validateMonthlyIncome(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Vui lòng nhập thu nhập hàng tháng';
  }

  final numVal = double.tryParse(value.replaceAll(',', ''));

  if (numVal == null) {
    return 'Thu nhập phải là số hợp lệ';
  }

  if (numVal <= 0) {
    return 'Thu nhập phải lớn hơn 0';
  }

  if (numVal > 1000000000) {
    return 'Thu nhập quá lớn (giới hạn 1,000,000,000)';
  }

  return null;
}

}
