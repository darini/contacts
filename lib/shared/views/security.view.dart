import 'package:contacts/android/services/local-authentication.service.dart';
import 'package:contacts/android/views/splash.view.dart';
import 'package:contacts/controllers/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SecurityView extends StatefulWidget {
  final AuthController authController;
  const SecurityView({super.key, required this.authController});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      authenticate(false);
    } else {
      authenticate(true);
    }
  }

  authenticate(bool auth) {
    if (auth) {
      widget.authController.setAuthenticated();
    } else {
      widget.authController.setUnauthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localAuthenticationService = LocalAuthenticationService();

    return Observer(builder: (_) {
      return widget.authController.authenticated
          ? const SizedBox()
          : SizedBox(
              child: SplashView(
                localAuthenticationService: localAuthenticationService,
                authController: widget.authController,
              ),
            );
    });
  }
}
