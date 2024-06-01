import 'package:flutter/material.dart';
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
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Boeken',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: snapshot.data!
                          .map((boek) => _BoekItem(
                                boek: boek,
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
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
    return Column(
      children: [
        ListTile(
          title: Text(boek.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          subtitle:
              Text(boek.author.name, style: const TextStyle(fontSize: 15)),
        ),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}
