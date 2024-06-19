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

class CreateUpdateBookArguments {
  final Book book;
  CreateUpdateBookArguments({required this.book});
}

class CreateUpdateBook extends StatelessWidget {
  final CreateUpdatePageArguments pageArgs;
  late final Future<Book>? book;

  CreateUpdateBook({super.key, required this.pageArgs}) {
    book = pageArgs.id != null
        ? ApiManager.fetchBook(pageArgs.id.toString())
        : null;
  }

  @override
  Widget build(BuildContext context) {
    String name = '';

    final MultiSelectController<String> genreController =
        MultiSelectController();
    final MultiSelectController<String> authorController =
        MultiSelectController();

    final formKey = GlobalKey<FormState>();

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        if (book != null) book!,
        ApiManager.fetchGenres(),
        ApiManager.fetchAuthors()
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Book? boekData = book != null ? snapshot.data![0] : null;
          List<Genre> genresData = snapshot.data![boekData != null ? 1 : 0];
          List<Author> authorsData = snapshot.data![boekData != null ? 2 : 1];
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                        pageArgs.crudType == CreateUpdatePageType.create
                            ? "Voeg een boek toe"
                            : "Bewerk een boek",
                        style: const TextStyle(fontSize: 35)),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Titel'),
                      initialValue: boekData?.name,
                      onChanged: (value) => name = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Vul een titel in' : null,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    MultiSelectDropDown(
                      hint: 'Genres',
                      controller: genreController,
                      onOptionSelected: (option) {},
                      options: genresData.map((genre) {
                        return ValueItem(
                            label: genre.name, value: genre.toString());
                      }).toList(),
                      selectedOptions: boekData != null
                          ? boekData.genres.map((genre) {
                              return ValueItem(
                                  label: genre.name, value: genre.toString());
                            }).toList()
                          : <ValueItem<String>>[],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    MultiSelectDropDown(
                      hint: 'Auteur',
                      controller: authorController,
                      selectionType: SelectionType.single,
                      onOptionSelected: (option) {},
                      options: authorsData.map((author) {
                        return ValueItem(
                            label: author.name, value: author.toString());
                      }).toList(),
                      selectedOptions: boekData != null
                          ? [
                              ValueItem(
                                  label: boekData.author.name,
                                  value: boekData.author.toString())
                            ]
                          : <ValueItem<String>>[],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CustomButton(
                        key: const Key('create_update_button'),
                        onPressed: () {
                          final valid = formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }
                          if (pageArgs.crudType ==
                              CreateUpdatePageType.create) {
                            ApiManager.createBook(Book(
                              name: name,
                              author: Author.fromString(authorController
                                  .selectedOptions.first.value!),
                              genres:
                                  genreController.selectedOptions.map((genre) {
                                return Genre.fromString(genre.value!);
                              }).toList(),
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ));
                          } else {
                            // ApiManager.updateBook(
                            //     id: boekData.id,
                            //     name: name,
                            //     authorId: authorId,
                            //     genreIds: genreIds);
                          }
                        },
                        child: Text(
                          pageArgs.crudType == CreateUpdatePageType.create
                              ? 'Voeg toe'
                              : 'Update',
                          style: const TextStyle(
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
