import 'package:flutter/material.dart';

//import '../utils/reference_utils.dart';

class CustomInputDecorator {
  static InputDecoration getInputDecoration(BuildContext context,
      [bool invert = false]) {
    const border =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    const style = TextStyle(fontSize: 16, color: Colors.blueGrey);
    return InputDecoration(
      focusedBorder: border,
      enabledBorder: border,
      errorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2)),
      focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.black, width: 2)),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      counterStyle: style,
      suffixStyle: style,
      errorMaxLines: 2,
      errorStyle: style.copyWith(fontWeight: FontWeight.bold),
      helperStyle: style,
      hintStyle: style,
      alignLabelWithHint: true,
      labelStyle: style.copyWith(fontWeight: FontWeight.bold),
      prefixStyle: style,
    );
  }
}
