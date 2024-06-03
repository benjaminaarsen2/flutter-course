import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/storage_classes/boek.dart';

/*
  TODO: implement some kind of class inheritance so that the CreateUpdatePage can be used for all classes
*/

enum CreateUpdatePageType { create, update }

abstract class CreatePageArguments {
  final String apiRoute;
  final CreateUpdatePageType type;

  CreatePageArguments({required this.apiRoute, required this.type});
}

class CreateUpdatePageArguments extends CreatePageArguments {
  final int? id;
  CreateUpdatePageArguments(
      {required super.apiRoute, required super.type, this.id});
}

class CreateUpdatePage extends StatelessWidget {
  final CreateUpdatePageArguments arguments;
  const CreateUpdatePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Titel'),
            initialValue:
                arguments.type == CreateUpdatePageType.update ? 'test' : null,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Beschrijving'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Genre'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Auteur'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CustomButton(
                key: const Key('create_update_button'),
                onPressed: () => {},
                child: Text(
                    arguments.type == CreateUpdatePageType.create
                        ? 'Create'
                        : 'Update',
                    style: const TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
    ));
  }
}

class CreateUpdateBoekArguments {
  final Boek boek;
  CreateUpdateBoekArguments({required this.boek});
}

class CreateUpdateBoek extends StatelessWidget {
  final Boek boek;

  const CreateUpdateBoek({super.key, required this.boek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Titel'),
            initialValue: boek.name,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Genre'),
            initialValue: boek.genres.map((e) => e.name).join(', '),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Auteur'),
            initialValue: boek.author.name,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CustomButton(
                key: const Key('create_update_button'),
                onPressed: () => {},
                child: const Text('Update',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          )
        ],
      ),
    ));
  }
}
