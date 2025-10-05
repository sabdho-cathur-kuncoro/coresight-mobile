import 'package:coresight/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final TextStyle labelStyle;
  final bool isTextArea;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final String? initialValue;
  final void Function(String)? onChanged;

  const CustomTextInput({
    super.key,
    required this.label,
    required this.hint,
    required this.labelStyle,
    this.maxLines = 5,
    this.isTextArea = false,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.textAlign = TextAlign.left,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: isTextArea ? maxLines : 1,
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: blackTextStyle.copyWith(fontSize: h6),
          textAlign: textAlign,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: greyTextStyle.copyWith(fontSize: h6),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: strokeColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: suffixIcon, // show icon only if not null
          ),
        ),
      ],
    );
  }
}
