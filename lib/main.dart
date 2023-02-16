import 'dart:io';
import 'package:contacts/ios/ios.app.dart';
import 'package:flutter/material.dart';
import 'package:contacts/android/android.app.dart';

void main() {
  // if (Platform.isIOS) {
  runApp(const IOSApp());
  //} else {
  //  runApp(const AndroidApp());
  //}
}
