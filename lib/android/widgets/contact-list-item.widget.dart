import 'dart:io';
import 'package:contacts/android/views/details.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel contactModel;

  const ContactListItem({super.key, required this.contactModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          image: DecorationImage(
            image: contactModel.image == null
                ? Image.asset('assets/images/profile-picture.png').image
                : FileImage(
                    File(contactModel.image!),
                  ),
          ),
        ),
      ),
      title: Text(contactModel.name!),
      subtitle: Text(contactModel.phone!),
      trailing: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsView(),
            ),
          );
        },
        child: Icon(
          Icons.chat,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
