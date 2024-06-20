import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        ...appState
          .favorites
          .map((pair) => ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asPascalCase)
          ))
          .toList()
      ]
    );
  }
}
