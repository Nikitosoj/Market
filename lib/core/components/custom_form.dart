import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(
      {super.key,
      this.label,
      this.hint,
      this.textStyle = const TextStyle(),
      required this.controller,
      this.obscure = false});
  final String? label;
  final String? hint;
  final TextStyle textStyle;
  final TextEditingController controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        hintText: hint,
      ),
    );
  }
}
