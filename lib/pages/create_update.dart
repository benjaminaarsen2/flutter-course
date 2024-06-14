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

    return FutureBuilder<List<dynamic>>(
      future: Future.wait(
          [book, ApiManager.fetchGenres(), ApiManager.fetchAuthors()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Book boekData = snapshot.data![0];
          List<Genre> genresData = snapshot.data![1];
          List<Author> authorsData = snapshot.data![2];
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
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    MultiSelectDropDown(
                      onOptionSelected: (option) {},
                      options: genresData.map((genre) {
                        return ValueItem(
                            label: genre.name, value: genre.id.toString());
                      }).toList(),
                      selectedOptions: boekData.genres.map((genre) {
                        return ValueItem(
                            label: genre.name, value: genre.id.toString());
                      }).toList(),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    MultiSelectDropDown(
                      selectionType: SelectionType.single,
                      onOptionSelected: (option) {},
                      options: authorsData.map((author) {
                        return ValueItem(
                            label: author.name, value: author.id.toString());
                      }).toList(),
                      selectedOptions: [
                        ValueItem(
                            label: boekData.author.name,
                            value: boekData.author.id.toString())
                      ],
                    ),

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
