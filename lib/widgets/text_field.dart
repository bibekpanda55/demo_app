import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../util/custom_input_decorator.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {this.controller,
      this.onSaved,
      this.hintText,
      this.validator,
      this.textInputType,
      this.onTap,
      this.maxLines,
      this.dropdownItems,
      this.onChanged,
      this.isPhone,
      this.isEmail,
      this.suffixIcon,
      this.readOnly,
      this.initialValue,
      this.prefixIcon,
      this.obscureText,
      this.onObscureIconTap,
      super.key});
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? hintText, initialValue;
  final TextInputType? textInputType;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool? readOnly, isPhone, obscureText, isEmail;
  final List<String>? dropdownItems;
  final Function(String? str)? onChanged;
  final int? maxLines;
  final Widget? suffixIcon, prefixIcon;
  final Function()? onObscureIconTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        validator: validator ??
            (value) => value!.trim().isEmpty
                ? "Cannot be empty!"
                : (isPhone ?? false)
                    ? validateMobile(value)
                    : (isEmail ?? false)
                        ? validateEmail(value)
                        : null,
        controller: controller,
        onSaved: onSaved,
        maxLines: maxLines,
        onTap: onTap,
        decoration: CustomInputDecorator.getInputDecoration(context).copyWith(
          contentPadding: const EdgeInsets.all(10),
          labelText: hintText,
          suffixIcon: onChanged != null && dropdownItems != null
              ? DropdownButton(
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                  underline: const SizedBox(),
                  items: dropdownItems!
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )))
                      .toList(),
                  onChanged: onChanged)
              : obscureText != null
                  ? IconButton(
                      onPressed: onObscureIconTap,
                      icon: Icon(
                        (obscureText ?? false)
                            ? FontAwesome5.eye_slash
                            : FontAwesome5.eye,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )
                  : suffixIcon,
          prefixIcon: prefixIcon,
        ));
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$';

    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Email';
    }
    return null;
  }
}
