import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function onTextChange;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool jumpToNext;
  final int numberOfLines;

  const CustomInputField({
    this.hintText,
    this.labelText,
    this.onTextChange,
    this.textInputType,
    this.textInputAction,
    this.jumpToNext,
    this.numberOfLines,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: TextField(
          keyboardType: textInputType,
          onChanged: onTextChange,
          maxLines: numberOfLines,
          textInputAction: TextInputAction.next,
          onSubmitted:
              jumpToNext ? (_) => FocusScope.of(context).nextFocus() : null,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 20.0, color: Colors.red),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(.5))),
        ),
      ),
    );
  }
}
