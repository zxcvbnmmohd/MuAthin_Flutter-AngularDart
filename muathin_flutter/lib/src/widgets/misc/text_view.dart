import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class TextView extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final double fontSize;
  final bool autoFocus;
  final bool obscureText;
  final bool autoCorrect;
  final int maxLines;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final Brightness keyboardAppearance;
  final GestureTapCallback onTap;

  const TextView(
      {this.margin,
      this.padding,
      this.controller,
      this.focusNode,
      this.label,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.fontSize,
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
      margin: this.margin,
      padding: this.padding,
      child: Center(
        child: TextField(
          controller: this.controller,
          focusNode: this.focusNode,
          decoration: InputDecoration(labelText: this.label),
          keyboardType: this.keyboardType,
          textInputAction: this.textInputAction,
          textCapitalization: this.textCapitalization,
          style: TextStyle(color: Config.sColor, fontSize: this.fontSize),
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
      ),
    );
  }
}
