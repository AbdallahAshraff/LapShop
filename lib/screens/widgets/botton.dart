import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  Widget buttonWidget;
  Function() function;
  double width;
  Color backgroundColor;
  bool isUpperCase;
  double radius;
  double height;
  Color borderColor;
  DefaultButton({
    super.key,
    this.height = 50,
    required this.buttonWidget,
    required this.function,
    this.backgroundColor = Colors.black,
    this.width = double.infinity,
    this.isUpperCase = true,
    this.radius = 5.0,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        height: 60,
        onPressed: function,
        child: buttonWidget,
      ),
    );
  }
}
