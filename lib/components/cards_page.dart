import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/create_update.dart';

class CardsPage extends StatelessWidget {
  final List<Widget> cards;
  final String title;

  const CardsPage({super.key, required this.title, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: cards,
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          width: 60,
          height: 60,
          child: CustomRoundButton(
              key: const Key('add_item_button'),
              onPressed: () => {
                    mainPageNavigatorKey.currentState!
                        .pushNamed('/create_update',
                            arguments: CreateUpdatePageArguments(
                              apiEndpoint: 'books',
                              crudType: CreateUpdatePageType.create,
                            ))
                  },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
      ]),
    );
  }
}
