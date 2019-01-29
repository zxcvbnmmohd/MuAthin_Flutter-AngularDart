import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextStyle hintStyle;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final int maxLines;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Brightness keyboardAppearance;
  final GestureTapCallback onTap;

  TextView(
      {this.controller,
        this.focusNode,
        this.hintText,
        this.hintStyle,
        this.keyboardType,
        this.textInputAction,
        this.textCapitalization = TextCapitalization.none,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.autoFocus = false,
        this.obscureText = false,
        this.autoCorrect = false,
        this.maxLines = 1,
        this.maxLength,
        this.onChanged,
        this.onSubmitted,
        this.keyboardAppearance,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      focusNode: this.focusNode,
      decoration: InputDecoration(border: InputBorder.none, hintText: this.hintText, hintStyle: this.hintStyle),
      keyboardType: this.keyboardType,
      textInputAction: this.textInputAction,
      textCapitalization: this.textCapitalization,
      style: TextStyle(color: this.color, fontSize: this.fontSize, fontWeight: this.fontWeight),
      textAlign: this.textAlign,
      autofocus: this.autoFocus,
      obscureText: this.obscureText,
      autocorrect: this.autoCorrect,
      maxLines: this.maxLines,
      maxLength: this.maxLength,
      onChanged: this.onChanged,
      onSubmitted: this.onSubmitted,
      keyboardAppearance: this.keyboardAppearance,
      onTap: this.onTap,
    );
  }
}
