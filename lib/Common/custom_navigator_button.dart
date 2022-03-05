import 'package:flutter/material.dart';

class CustomNavigatorButton {
  static Widget customButton({
    required String boxName,
    required VoidCallback onTap,
    required BuildContext context,
    required Size size,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width / 3,
        height: size.height / 18,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            boxName,
            style: TextStyle(
              fontSize: size.height * 0.03,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
