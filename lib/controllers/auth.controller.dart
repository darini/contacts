import 'package:mobx/mobx.dart';

part 'auth.controller.g.dart';

class AuthController extends _AuthController with _$AuthController {}

abstract class _AuthController with Store {
  @observable
  bool authenticated = false;

  @action
  setAuthenticated() {
    authenticated = true;
  }

  @action
  setUnauthenticated() {
    authenticated = false;
  }
}
