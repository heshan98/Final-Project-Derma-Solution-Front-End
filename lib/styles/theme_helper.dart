import 'dart:ffi';

import 'package:flutter/material.dart';

class ThemeHelper {
  InputDecoration textInputStyle(
      Widget prefixIcon, [
        String labelText = " ",
        String hintText = " ",
        bool backGroundColor = false,
      ]) {
    return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: backGroundColor ? Colors.grey.shade200 : Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        prefixIcon: prefixIcon);
  }
}