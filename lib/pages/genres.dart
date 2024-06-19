import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/cards_page.dart';
import 'package:flutter_application_1/components/clickable_card.dart';
import 'package:flutter_application_1/providers/api_manager.dart';
import 'package:flutter_application_1/storage_classes/genre.dart';

class Genres extends StatelessWidget {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Genre>>(
      future: ApiManager.fetchGenres(),
      builder: (BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CardsPage(
              apiEndpoint: 'genres',
              title: 'Genres',
              cards: snapshot.data!
                  .map((genre) => _GenreItem(
                        genre: genre,
                      ))
                  .toList());
        }
      },
    );
  }
}

class _GenreItem extends StatelessWidget {
  final Genre genre;

  Genre get getGenre => genre;
  const _GenreItem({required this.genre});

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      child: ListTile(
        title: Text(genre.name),
      ),
      onPressed: () => {},
    );
  }
}
