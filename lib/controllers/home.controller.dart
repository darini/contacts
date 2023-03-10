import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:mobx/mobx.dart';

part 'home.controller.g.dart';

class HomeController extends _HomeController with _$HomeController {}

abstract class _HomeController with Store {
  @observable
  bool showSearch = false;

  @observable
  ObservableList<ContactModel> contacts = ObservableList<ContactModel>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String param) async {
    final repository = ContactRepository();

    contacts = ObservableList<ContactModel>();

    var contactsResult = await repository.searchContacts(param);
    contacts.addAll(contactsResult);
  }
}
