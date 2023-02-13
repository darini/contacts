import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/android/views/loading.view.dart';
import 'package:contacts/shared/widgets/contact-details-description.widget.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:contacts/shared/widgets/contact-details-image.widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  final int id;
  const DetailsView({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _repository = ContactRepository();

  onDelete() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exclusão de Contato'),
            content: const Text('Deseja excluir esse contato?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  delete();
                },
                child: const Text('Excluir'),
              ),
            ],
          );
        });
  }

  delete() {
    _repository.delete(ContactModel(id: widget.id)).then((_) {
      onSuccess();
    }).catchError((onError) {
      onError();
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  onError() {
    SnackBar snackBar = const SnackBar(
      content: Text('Ops, algo deu errado'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _repository.getContact(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return page(context, snapshot.data!);
          } else {
            return const LoadingView();
          }
        });
  }

  Widget page(BuildContext context, ContactModel contactModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contato"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
            width: double.infinity,
          ),
          ContactDetailsImage(
            image: contactModel.image,
          ),
          const SizedBox(
            height: 10,
          ),
          ContactDetailsDescription(
            name: contactModel.name!,
            phone: contactModel.phone!,
            email: contactModel.email!,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  final Uri _uri = Uri.parse(
                    'tel:${contactModel.phone}'
                        .replaceAll('(', '')
                        .replaceAll(')', '')
                        .replaceAll('-', ''),
                  );
                  launchUrl(_uri);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              TextButton(
                onPressed: () {
                  final Uri _uri = Uri.parse('mailto:${contactModel.email}');
                  launchUrl(_uri);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.camera_enhance,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: const Text(
              "Endereço",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contactModel.addressLine1 ?? 'Nenhum endereço cadastrado',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  contactModel.addressLine2 ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressView(),
                  ),
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              color: Colors.red,
              height: 50,
              child: TextButton(
                onPressed: onDelete,
                child: Text(
                  'Excluir Contato',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorContactView(
                contactModel: ContactModel(
                    id: contactModel.id,
                    name: contactModel.name,
                    email: contactModel.email,
                    phone: contactModel.phone,
                    addressLine1: contactModel.addressLine1 ?? '',
                    addressLine2: contactModel.addressLine2 ?? '',
                    latLng: contactModel.latLng),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
