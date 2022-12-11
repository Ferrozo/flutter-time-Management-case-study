import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomBtn({required this.onClick, required this.btnTxt});
  final Function onClick;
  final String btnTxt;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onClick(), child: Text(btnTxt));
  }
}
