// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on _AuthController, Store {
  late final _$authenticatedAtom =
      Atom(name: '_AuthController.authenticated', context: context);

  @override
  bool get authenticated {
    _$authenticatedAtom.reportRead();
    return super.authenticated;
  }

  @override
  set authenticated(bool value) {
    _$authenticatedAtom.reportWrite(value, super.authenticated, () {
      super.authenticated = value;
    });
  }

  late final _$_AuthControllerActionController =
      ActionController(name: '_AuthController', context: context);

  @override
  dynamic setAuthenticated() {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.setAuthenticated');
    try {
      return super.setAuthenticated();
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUnauthenticated() {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.setUnauthenticated');
    try {
      return super.setUnauthenticated();
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authenticated: ${authenticated}
    ''';
  }
}
