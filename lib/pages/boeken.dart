import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cards_page.dart';
import 'package:flutter_application_1/components/clickable_card.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/create_update.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/boek.dart';

class Boeken extends StatelessWidget {
  const Boeken({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Boek>>(
      future: ApiManager.fetchBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Boek>> snapshot) {
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
                  .map((boek) => _BoekItem(
                        boek: boek,
                      ))
                  .toList());
        }
      },
    );
  }
}

class _BoekItem extends StatelessWidget {
  final Boek boek;

  Boek get getBoek => boek;
  const _BoekItem({required this.boek});

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      child: ListTile(
        title: Text(boek.name),
        subtitle: Text(boek.author.name),
      ),
      onPressed: () => {
        mainPageNavigatorKey.currentState!.pushNamed('/create_update_boek',
            arguments: CreateUpdateBoekArguments(boek: boek))
      },
    );
  }
}
