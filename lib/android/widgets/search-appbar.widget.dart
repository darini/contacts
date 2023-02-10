import 'package:contacts/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchAppBar extends StatelessWidget {
  final HomeController controller;

  const SearchAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Observer(
        builder: (_) => controller.showSearch
            ? TextField(
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Pesquisar...',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
                onSubmitted: (val) {
                  controller.search(val);
                },
              )
            : const Text('Meus Contatos'),
      ),
      centerTitle: true,
      leading: TextButton(
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch ? Icons.close : Icons.search,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
      ),
    );
  }
}
