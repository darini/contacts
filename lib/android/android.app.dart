import 'package:contacts/android/services/local-authentication.service.dart';
import 'package:contacts/android/styles.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/controllers/auth.controller.dart';
import 'package:contacts/shared/views/security.view.dart';
import 'package:flutter/material.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return MaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: androidTheme(),
      home: Stack(
        children: <Widget>[
          const HomeView(),
          SecurityView(
            authController: authController,
          ),
        ],
      ),
    );
  }
}
