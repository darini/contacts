// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeController, Store {
  late final _$showSearchAtom =
      Atom(name: '_HomeController.showSearch', context: context);

  @override
  bool get showSearch {
    _$showSearchAtom.reportRead();
    return super.showSearch;
  }

  @override
  set showSearch(bool value) {
    _$showSearchAtom.reportWrite(value, super.showSearch, () {
      super.showSearch = value;
    });
  }

  late final _$contactsAtom =
      Atom(name: '_HomeController.contacts', context: context);

  @override
  ObservableList<ContactModel> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<ContactModel> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$searchAsyncAction =
      AsyncAction('_HomeController.search', context: context);

  @override
  Future search(String param) {
    return _$searchAsyncAction.run(() => super.search(param));
  }

  late final _$_HomeControllerActionController =
      ActionController(name: '_HomeController', context: context);

  @override
  dynamic toggleSearch() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.toggleSearch');
    try {
      return super.toggleSearch();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showSearch: ${showSearch},
contacts: ${contacts}
    ''';
  }
}
