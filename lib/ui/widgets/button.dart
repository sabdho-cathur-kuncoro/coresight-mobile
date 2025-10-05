import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final double borderRad;
  final double? borderWidth;
  final Color bgColor;
  final Color? borderColor;
  final TextStyle styleText;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.styleText,
    this.borderRad = 10,
    this.height = 50,
    this.width = double.infinity,
    this.borderColor,
    this.borderWidth,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRad),
            side: (borderColor != null && borderWidth != null)
                ? BorderSide(color: borderColor!, width: borderWidth!)
                : BorderSide.none,
          ),
        ),
        child: Text(text, style: styleText),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final TextStyle styleText;
  final VoidCallback? onPressed;

  const ButtonText({
    super.key,
    required this.text,
    required this.styleText,
    this.height = 24,
    this.width = double.infinity,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(text, style: styleText),
      ),
    );
  }
}
