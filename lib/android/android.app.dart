import 'package:contacts/android/services/local-authentication.service.dart';
import 'package:contacts/android/styles.dart';
import 'package:contacts/android/views/splash.view.dart';
import 'package:flutter/material.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final localAuthService = LocalAuthenticationService();

    return MaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: SplashView(localAuthenticationService: localAuthService),
    );
  }
}
