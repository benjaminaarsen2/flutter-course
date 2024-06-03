import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cards_page.dart';
import 'package:flutter_application_1/components/clickable_card.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/auteur.dart';

class Auteurs extends StatelessWidget {
  const Auteurs({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Auteur>>(
      future: ApiManager.fetchAuthors(),
      builder: (BuildContext context, AsyncSnapshot<List<Auteur>> snapshot) {
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
                  .map((auteur) => _AuteurItem(
                        auteur: auteur,
                      ))
                  .toList());
        }
      },
    );
  }
}

class _AuteurItem extends StatelessWidget {
  final Auteur auteur;

  Auteur get getAuteur => auteur;
  const _AuteurItem({required this.auteur});

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
