import 'package:flutter/material.dart';

class AppStyles {
  static const colorRed = Color.fromRGBO(231, 28, 36, 1);
  static const colorGreen = Color.fromRGBO(33, 191, 115, 1);
  static const colorWhite = Color.fromRGBO(255, 255, 255, 1);
  static const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

  // Styles for text field
  static InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: colorGreen,
          width: 1,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: colorWhite,
          width: 0,
        ),
      ),
      fillColor: colorWhite,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      labelText: labelText,
      floatingLabelStyle: TextStyle(color: colorGreen),
    );
  }

  // Styles for dropdown
  static Container appDropDownStyle(child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorWhite, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  // Styles for elevated button
  static ButtonStyle appButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: colorGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
    );
  }

  // Styles for grid view

  static SliverGridDelegateWithFixedCrossAxisCount productGridView() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      mainAxisExtent: 250,
    );
  }
}
