import 'package:fitrah/config/configScheme.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final Widget icon;
  final Widget? icon1;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.icon,
      this.icon1
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          style: TextStyle(color: darkBlue),
          cursorColor: darkBlue,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: icon,
            suffixIcon: icon1,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(29)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkBlue),
                borderRadius: BorderRadius.circular(29)),
            labelText: labelText,
            labelStyle: TextStyle(color: darkBlue),
            fillColor: lightBlue,
            filled: true,
          )),
    );
  }
}
