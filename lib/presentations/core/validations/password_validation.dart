class PasswordValidation {

  static String? validatePassword(String? value) {

    if (value!.isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  static String? validateRegisterPassword(String? value) {

    if (value!.isEmpty) {
      return 'Password is required.';
    }

    final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$');

    return !regex.hasMatch(value)
        ? 'Password must contain:\n- Minimum 1 upper case.\n- Minimum 1 lower case.\n- Minimum 1 digit.\n- Minimum 1 special character.\n- Minimum 8 characters in length.'
        : null;
  }
}
