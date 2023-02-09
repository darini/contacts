import 'package:flutter/cupertino.dart';

const brightness = Brightness.light;
const primaryColor = Color(0xFF2AACFF);
const accentColor = Color(0xFFFFFFFF);

CupertinoThemeData iosTheme() {
  return const CupertinoThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
  );
}
