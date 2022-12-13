import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomBtn({
    this.onClick,
    required this.icon,
    required this.color,
    required this.borderColor,
  });

  final Function? onClick;
  final Icon icon;
  final Color borderColor;
  final Color color;
  final double containerSize = 60;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 2, color: borderColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
          onPressed: () {
            onClick!();
          },
          icon: icon),
    );
  }
}
