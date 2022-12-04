import 'package:flutter/material.dart';

class CustomTextFieldExtra extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Icon icon;
  final int maxLines;

  const CustomTextFieldExtra({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsecureText = false,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: icon,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Masukkan $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
