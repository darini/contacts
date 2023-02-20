import 'package:contacts/android/services/local-authentication.service.dart';
import 'package:contacts/android/views/splash.view.dart';
import 'package:flutter/material.dart';

class SecurityView extends StatefulWidget {
  final Widget widget;
  const SecurityView({super.key, required this.widget});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView>
    with WidgetsBindingObserver {
  bool auth = true;

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
      setState(() {
        auth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localAuthenticationService = LocalAuthenticationService();

    return auth
        ? widget.widget
        : SplashView(localAuthenticationService: localAuthenticationService);
  }
}
