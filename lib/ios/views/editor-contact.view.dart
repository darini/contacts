import 'package:contacts/ios/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/cupertino.dart';

class EditorContactView extends StatefulWidget {
  final ContactModel contactModel;

  const EditorContactView({Key? key, required this.contactModel})
      : super(key: key);

  @override
  State<EditorContactView> createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _formKey = GlobalKey<FormState>();
  final _repository = ContactRepository();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (widget.contactModel.id == 0) {
      create();
    } else {
      update();
    }
  }

  create() {
    _repository
        .create(widget.contactModel)
        .then(
          (_) => {
            onSuccess(),
          },
        )
        .onError(
          (error, stackTrace) => {
            onError(),
          },
        );
  }

  update() {
    _repository
        .update(widget.contactModel)
        .then(
          (_) => {
            onSuccess(),
          },
        )
        .onError(
          (error, stackTrace) => {
            onError(),
          },
        );
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
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: widget.contactModel.id == 0
                ? const Text("Novo Contato")
                : const Text("Editar Contato"),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CupertinoTextField(
                      placeholder: widget.contactModel.name,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        widget.contactModel.name = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.contactModel.phone,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {
                        widget.contactModel.phone = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CupertinoTextField(
                      placeholder: widget.contactModel.email,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        widget.contactModel.email = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CupertinoButton.filled(
                        onPressed: () {},
                        child: const Text(
                          "Salvar",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
