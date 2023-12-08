import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.keyboardType,
    this.onChanged,
    this.style,
    this.cursorColor,
    this.fillColor,
    this.prefixColor,
    this.hintStyle,
    required this.controller,
    Key? key,
  }) : super(key: key);
  TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  Function(String)? onChanged;
  Color? cursorColor;
  TextStyle? style;
  Color? fillColor;
  Color? prefixColor;
  TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (dynamic value) {
        if (value.isEmpty) {
          return 'Field Cannot be empty';
        }
        return null;
      },
      cursorColor: cursorColor,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: style,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(18.0),
        filled: false,
        fillColor: fillColor,
        prefixIcon: Icon(
          icon,
          size: 24.0,
          color: prefixColor,
        ),
        labelText: hintText,
        labelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
