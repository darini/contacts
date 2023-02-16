import 'package:contacts/ios/views/address.view.dart';
import 'package:contacts/ios/views/editor-contact.view.dart';
import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/ios/views/loading.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:contacts/shared/widgets/contact-details-description.widget.dart';
import 'package:contacts/shared/widgets/contact-details-image.widget.dart';
import 'package:flutter/cupertino.dart';
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
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(
              'Exclusão de Contato',
            ),
            content: const Text(
              'Deseja excluir esse contato?',
            ),
            actions: <Widget>[
              CupertinoButton(
                child: const Text(
                  'Cancelar',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoButton(
                onPressed: delete,
                child: const Text(
                  'Excluir',
                ),
              ),
            ],
          );
        });
  }

  delete() {
    _repository.delete(ContactModel(id: widget.id)).then((_) {
      onSuccess();
    }).catchError((onError) {});
  }

  onSuccess() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  onError() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Falha na operação'),
          content: const Text('Ops, algo deu erro'),
          actions: [
            CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ContactModel contactModel = snapshot.data!;
          return CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: const Text('Contato'),
                  trailing: GestureDetector(
                    child: const Icon(CupertinoIcons.pen),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              EditorContactView(contactModel: contactModel),
                        ),
                      );
                    },
                  ),
                ),
                SliverFillRemaining(
                  child: Column(
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
                          CupertinoButton(
                            child: const Icon(
                              CupertinoIcons.phone,
                            ),
                            onPressed: () {
                              final Uri _uri = Uri.parse(
                                'tel:${contactModel.phone}'
                                    .replaceAll('(', '')
                                    .replaceAll(')', '')
                                    .replaceAll('-', ''),
                              );
                              launchUrl(_uri);
                            },
                          ),
                          CupertinoButton(
                            child: const Icon(
                              CupertinoIcons.mail,
                            ),
                            onPressed: () {
                              final Uri uri =
                                  Uri.parse('mailto:${contactModel.email}');
                              launchUrl(uri);
                            },
                          ),
                          CupertinoButton(
                            child: const Icon(
                              CupertinoIcons.photo_camera,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    width: double.infinity,
                                  ),
                                  const Text(
                                    "Endereço",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    contactModel.addressLine1 ??
                                        'Nenhum endereço cadastrado',
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
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const AddressView(),
                                  ),
                                );
                              },
                              child: const Icon(
                                CupertinoIcons.location,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton.filled(
                        onPressed: onDelete,
                        child: const Text(
                          'Excluir Contato',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const LoadginView();
        }
      },
    );
  }
}
