class Validators {
  Validators._();

  // Strong password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  // Compare password validator
  static String? validateConfirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // A solid, non-overkill email regex
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return 'Name must be at least 3 characters long';
    }

    final nameParts = trimmedValue.split(RegExp(r'\s+'));
    if (nameParts.length < 2) {
      return 'Please enter your first and last name';
    }

    for (final part in nameParts) {
      if (part.length < 2) {
        return 'Each name must be at least 2 characters long';
      }
    }

    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(trimmedValue)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  static String? validateBvnOrNin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your bvn';
    }
    if (value.length < 11) {
      return "11 digits are required";
    }

    return null;
  }

  static String? validateNigerianPhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!RegExp(r'^\+?\d+$').hasMatch(cleanedValue)) {
      return 'Phone number can only contain digits';
    }

    if (cleanedValue.startsWith('+234')) {
      if (cleanedValue.length != 14) {
        return 'Invalid phone number format';
      }
      final localNumber = cleanedValue.substring(4);
      if (!_isValidNigerianPrefix(localNumber)) {
        return 'Invalid Nigerian phone number prefix';
      }
      return null;
    }

    if (cleanedValue.startsWith('234')) {
      if (cleanedValue.length != 13) {
        return 'Invalid phone number format';
      }
      final localNumber = cleanedValue.substring(3);
      if (!_isValidNigerianPrefix(localNumber)) {
        return 'Invalid Nigerian phone number prefix';
      }
      return null;
    }

    if (cleanedValue.startsWith('0')) {
      if (cleanedValue.length != 11) {
        return 'Phone number must be 11 digits';
      }
      if (!_isValidNigerianPrefix(cleanedValue.substring(1))) {
        return 'Invalid Nigerian phone number prefix';
      }
      return null;
    }

    if (cleanedValue.length == 10) {
      if (!_isValidNigerianPrefix(cleanedValue)) {
        return 'Invalid Nigerian phone number prefix';
      }
      return null;
    }

    return 'Invalid phone number format';
  }

  static bool _isValidNigerianPrefix(String localNumber) {
    if (localNumber.length != 10) return false;

    final prefix = localNumber.substring(0, 2);
    final validPrefixes = ['70', '80', '81', '90', '91'];

    return validPrefixes.contains(prefix);
  }

  static String formatNigerianPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleaned.startsWith('+234') && cleaned.length == 14) {
      final local = '0${cleaned.substring(4)}';
      return '${local.substring(0, 4)} ${local.substring(4, 7)} ${local.substring(7)}';
    }

    if (cleaned.startsWith('234') && cleaned.length == 13) {
      final local = '0${cleaned.substring(3)}';
      return '${local.substring(0, 4)} ${local.substring(4, 7)} ${local.substring(7)}';
    }

    if (cleaned.startsWith('0') && cleaned.length == 11) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    }

    if (cleaned.length == 10) {
      final local = '0$cleaned';
      return '${local.substring(0, 4)} ${local.substring(4, 7)} ${local.substring(7)}';
    }

    return phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
}
