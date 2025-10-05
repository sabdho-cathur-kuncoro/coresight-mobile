import 'package:flutter/services.dart';

void setStatusBar({
  required Color color,
  required Brightness iconBrightness,
  Brightness barBrightness = Brightness.light,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarBrightness:
          barBrightness, // controls status bar text/icons color on iOS
      statusBarIconBrightness: iconBrightness,
    ),
  );
}
