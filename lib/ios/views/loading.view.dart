import 'package:flutter/cupertino.dart';

class LoadginView extends StatelessWidget {
  const LoadginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
