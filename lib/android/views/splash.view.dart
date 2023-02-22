import 'package:contacts/android/services/ilocal-auth.service.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/controllers/auth.controller.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final ILocalAuthService localAuthenticationService;
  final AuthController authController;
  const SplashView({
    Key? key,
    required this.localAuthenticationService,
    required this.authController,
  }) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  initState() {
    super.initState();

    Future.delayed(
      const Duration(
        seconds: 2,
      ),
    ).then((_) {
      widget.localAuthenticationService.stopAuthenticate().then(
            (_) => auth(),
          );
    });
  }

  auth() {
    widget.localAuthenticationService.authenticate().then((result) {
      if (result) {
        widget.authController.setAuthenticated();
      }
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
          ),
          Icon(
            Icons.fingerprint,
            size: 72,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Meus Contatos",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
