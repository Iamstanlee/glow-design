import 'package:flutter/widgets.dart';

// validators
void validateForm(GlobalKey<FormState> formKey, VoidCallback valid) {
  FormState formState = formKey.currentState;
  if (formState.validate()) {
    formState.save();
    valid();
  }
}

String validatePassword(String password) {
  if (password.isEmpty) return "Password field cannot be empty";
  if (password.length < 8) return "Password must be greater than 7 characters";
  return null; // return null if valid
}

String validateConfirmPassword(String p1, String p2) {
  if (p1 != p2) return "Password does not match";
  return null; // return null if valid
}

String validateUname(String name) {
  if (name.isEmpty) return "Username field cannot be empty";
  return null; // return null if valid
}

String validateRegularField(String field) {
  if (field.isEmpty) return "This field is required";
  return null; // return null if valid
}

String validateFname(String name) {
  if (name.isEmpty) return "Fullname field cannot be empty";
  // if (name.contains(new RegExp(r'[0-9]'))) return 'Invalid name';
  return null; // return null if valid
}

String validatePhoneNumber(String number) {
  if (number.isEmpty) return "Phonenumber field cannot be empty";
  if (number.length != 11)
    return 'Your phone number must consist of 11 characters';
  return null; // return null if valid
}

String validateEmail(String email) {
  if (email.isEmpty) return "Email field cannot be empty";
  // if (email.contains(new RegExp(r'[0-9]'))) return 'Invalid name';
  return null; // return null if valid
}
