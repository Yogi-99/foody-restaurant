import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final Function onTextChange;
  final bool isObscure;
  final TextInputType inputType;
  final bool showDivider;

  InputField({
    this.hint,
    this.onTextChange,
    this.inputType,
    this.showDivider,
    this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            keyboardType: inputType,
            obscureText: isObscure ? true : false,
            onChanged: onTextChange,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(.9),
                ),
                hintText: hint),
          ),
        ),
        showDivider
            ? Divider(
                height: 1.0,
                color: Colors.redAccent.withOpacity(.4),
              )
            : Container(),
      ],
    );
  }
}
