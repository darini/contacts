import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/widgets/contact-list-item.widget.dart';
import 'package:contacts/android/widgets/search-appbar.widget.dart';
import 'package:contacts/controllers/home.controller.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/shared/views/security.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.search("");
  }

  @override
  Widget build(BuildContext context) {
    return SecurityView(widget: home());
  }

  Widget home() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SearchAppBar(
          controller: controller,
        ),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            return ContactListItem(
              contactModel: controller.contacts[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                contactModel: ContactModel(id: 0),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
