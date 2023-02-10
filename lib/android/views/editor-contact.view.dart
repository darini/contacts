import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:flutter/material.dart';

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

  update() {}

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
    return Scaffold(
      appBar: AppBar(
        title: widget.contactModel.id == 0
            ? const Text("Novo Contato")
            : const Text("Editar Contato"),
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.contactModel.name,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onChanged: (val) {
                  widget.contactModel.name = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Nome inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: widget.contactModel.phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                onChanged: (val) {
                  widget.contactModel.phone = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Telefone inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: widget.contactModel.email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                onChanged: (val) {
                  widget.contactModel.email = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'E-mail inválido';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    onSubmit();
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
