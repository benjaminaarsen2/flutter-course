import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cards_page.dart';
import 'package:flutter_application_1/components/clickable_card.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/author.dart';

class Authors extends StatelessWidget {
  const Authors({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Author>>(
      future: ApiManager.fetchAuthors(),
      builder: (BuildContext context, AsyncSnapshot<List<Author>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CardsPage(
              title: 'Auteurs',
              cards: snapshot.data!
                  .map((auteur) => _AuthorItem(
                        auteur: auteur,
                      ))
                  .toList());
        }
      },
    );
  }
}

class _AuthorItem extends StatelessWidget {
  final Author auteur;

  Author get getAuteur => auteur;
  const _AuthorItem({required this.auteur});

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      child: ListTile(
        title: Text(auteur.name),
        subtitle: Text("Leeftijd: ${auteur.age}"),
      ),
      onPressed: () => {},
    );
  }
}
