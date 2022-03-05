import 'package:flutter/material.dart';

class CustomTextField {
  static TextFormField customTextField({
    required TextEditingController controller,
    int? maxLength,
    TextInputType? textInputType,
    String? hintText,
    double? textSpacing,
    Widget? prefix,
    Widget? suffixIcon,
    bool? readOnly,
    bool obscureText = false,
    FocusNode? focusnode,
    required String? Function(String? value) validator,
  }) {
    return TextFormField(
      focusNode: focusnode,
      readOnly: readOnly ?? false,
      obscureText: obscureText,
      controller: controller,
      maxLength: maxLength,
      validator: validator,
      keyboardType: textInputType,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: textSpacing,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        counterText: "",
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: Colors.grey[200]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
