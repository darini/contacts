import 'dart:io';
import 'package:contacts/ios/styles.dart';
import 'package:contacts/ios/views/details.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/cupertino.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel contactModel;
  const ContactListItem({super.key, required this.contactModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: contactModel.image == null
                  ? Image.asset('assets/images/profile-picture.png').image
                  : FileImage(
                      File(contactModel.image!),
                    ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactModel.name!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  contactModel.phone!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        CupertinoButton(
          child: const Icon(
            CupertinoIcons.person,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => DetailsView(
                  id: contactModel.id,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
