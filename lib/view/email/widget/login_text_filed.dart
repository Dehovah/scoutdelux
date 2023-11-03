import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';

class LoginTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;

  const LoginTextFiled(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: colorPrimary,
          borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        cursorColor: colorTextLight,
        cursorHeight: 15,
        style: TextStyle(
            color: colorTextLight, fontSize: 15, fontFamily: fNSfUiMedium),
      ),
    );
  }
}
