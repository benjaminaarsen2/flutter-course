import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/book.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../storage_classes/author.dart';
import '../storage_classes/genre.dart';

/*
  TODO: implement some kind of class inheritance so that the CreateUpdatePage can be used for all classes
*/

enum CreateUpdatePageType { create, update }

abstract class CreatePageArguments {
  final String apiEndpoint; // for example 'books' or 'authors'
  final CreateUpdatePageType crudType; // create or update

  CreatePageArguments({required this.apiEndpoint, required this.crudType});
}

class CreateUpdatePageArguments extends CreatePageArguments {
  final int? id; // id of the object to update
  CreateUpdatePageArguments(
      {required super.apiEndpoint, required super.crudType, this.id});
}

class CreateUpdatePage extends StatelessWidget {
  final CreateUpdatePageArguments arguments;
  const CreateUpdatePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    switch (arguments.apiEndpoint) {
      case 'boek':
        Future<Book> boek = ApiManager.fetchBook(arguments.id.toString());
        return CreateUpdateBook(
          book: boek,
        );
      default:
        return Text('Page ${arguments.apiEndpoint} not found');
    }
  }
}

class CreateUpdateBookArguments {
  final Book book;
  CreateUpdateBookArguments({required this.book});
}

class CreateUpdateBook extends StatelessWidget {
  final Future<Book> book;

  const CreateUpdateBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String name;
    List<Genre> genres;
    Author author;

    List<String> genreNames = [];
    String authorName = '';

    return FutureBuilder<Book>(
      future: book,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Book boekData = snapshot.data!;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Titel'),
                      initialValue: boekData.name,
                      onChanged: (value) => name = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Vul een titel in' : null,
                    ),
                    // TODO: Genre multidropdown
                    MultiSelectDropDown(
                        onOptionSelected: (option) {}, options: []),
                    // TODO: Auteur dropdown
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CustomButton(
                        key: const Key('create_update_button'),
                        onPressed: () => {},
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
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
      },
    );
  }
}
