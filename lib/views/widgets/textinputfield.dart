import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class Textinputfield extends StatelessWidget {
  final bool toHide;
  final TextEditingController controller;
  final IconData myIcon;
  final String LabelText;

  Textinputfield({required this.controller,required this.LabelText,required this.myIcon,this.toHide=false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,
      decoration: InputDecoration(
      icon: Icon(myIcon),
      labelText: LabelText,
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
    color: bordercolor
  )
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
      color: bordercolor
      )
  )
  ),
    );
  }
}
