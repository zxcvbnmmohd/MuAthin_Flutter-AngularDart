import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class TextBox extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final double fontSize;
  final FontWeight fontWeight;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final int maxLines;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Brightness keyboardAppearance;
  final GestureTapCallback onTap;

  const TextBox(
      {this.margin,
      this.padding,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.fontSize,
      this.fontWeight,
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
    return Container(
      padding: this.padding,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Config.sColor.withOpacity(0.2)),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: this.margin,
      child: TextField(
        controller: this.controller,
        focusNode: this.focusNode,
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: this.keyboardType,
        textInputAction: this.textInputAction,
        textCapitalization: this.textCapitalization,
        style: TextStyle(color: Config.sColor, fontSize: this.fontSize, fontWeight: this.fontWeight),
        autofocus: this.autoFocus,
        obscureText: this.obscureText,
        autocorrect: this.autoCorrect,
        maxLines: this.maxLines,
        maxLength: this.maxLength,
        onChanged: this.onChanged,
        onSubmitted: this.onSubmitted,
        keyboardAppearance: this.keyboardAppearance,
        onTap: this.onTap,
      ),
    );
  }
}
