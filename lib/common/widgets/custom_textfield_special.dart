import 'package:flutter/material.dart';

class CustomTextFieldSpecial extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Icon icon;
  final int maxLines;
  final String errorMessage;

  const CustomTextFieldSpecial({
    super.key,
    required this.controller,
    required this.hintText,
    this.obsecureText = false,
    required this.icon,
    this.maxLines = 1,
    this.errorMessage = '',
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
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return errorMessage.isEmpty ? 'Masukkan $hintText' : errorMessage;
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
