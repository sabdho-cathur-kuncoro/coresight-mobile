import 'package:coresight/shared/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TapToPhoto extends StatelessWidget {
  final VoidCallback? onPressed;
  const TapToPhoto({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: primaryColor,
          strokeWidth: 1,
          dashPattern: [6, 3], // 6 = dash, 3 = gap
          radius: Radius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: subtleGreyColor),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content tightly vertically
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.asset(
                    'assets/icons/ic_camera.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tap here to take a photo',
                  style: blackTextStyle.copyWith(
                    fontSize: h5,
                    letterSpacing: header,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
