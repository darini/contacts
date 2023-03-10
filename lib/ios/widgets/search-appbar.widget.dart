import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/controllers/home.controller.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchAppBar extends StatelessWidget with ObstructingPreferredSizeWidget {
  final HomeController controller;
  const SearchAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Observer(
        builder: (_) => controller.showSearch
            ? CupertinoTextField(
                autofocus: true,
                onSubmitted: (val) {
                  controller.search(val);
                },
              )
            : const Text('Meus Contatos'),
      ),
      leading: GestureDetector(
        onTap: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch
                ? CupertinoIcons.clear
                : CupertinoIcons.search,
          ),
        ),
      ),
      trailing: GestureDetector(
        child: const Icon(
          CupertinoIcons.add,
        ),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => EditorContactView(
                contactModel: ContactModel(
                  id: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
