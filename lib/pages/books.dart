import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cards_page.dart';
import 'package:flutter_application_1/components/clickable_card.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/create_update.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/book.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: ApiManager.fetchBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CardsPage(
              title: 'Boeken',
              cards: snapshot.data!
                  .map((boek) => _BookItem(
                        boek: boek,
                      ))
                  .toList());
        }
      },
    );
  }
}

class _BookItem extends StatelessWidget {
  final Book boek;

  Book get getBoek => boek;
  const _BookItem({required this.boek});

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      child: ListTile(
        title: Text(boek.name),
        subtitle: Text(boek.author.name),
      ),
      onPressed: () => {
        mainPageNavigatorKey.currentState!.pushNamed('/create_update',
            arguments: CreateUpdatePageArguments(
                apiEndpoint: 'books',
                crudType: CreateUpdatePageType.update,
                id: boek.id))
      },
    );
  }
}
