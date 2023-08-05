import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {required this.onPressed, this.loading, required this.text, super.key});
  final Function() onPressed;
  final bool? loading;
  final String text;
  @override
  Widget build(BuildContext context) {
    final wh = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.green[700],
          fixedSize: Size(wh, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: onPressed,
      child: loading ?? false
          ? const CupertinoActivityIndicator()
          : Text(
              text,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
    );
  }
}

class ShortButtonWidget extends StatelessWidget {
  const ShortButtonWidget(
      {required this.onPressed,
      required this.text,
      this.elevation,
      this.buttonColor,
      this.textColor,
      super.key});
  final Function() onPressed;
  final double? elevation;
  final Color? textColor, buttonColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: elevation ?? 0,
            minimumSize: const Size(200, 60),
            backgroundColor: buttonColor ?? Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ));
  }
}
