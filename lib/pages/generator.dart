
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  
	@override
	Widget build(BuildContext context) {
		var appState = context.watch<AppState>();
    var pair = appState.current;

    var icon = appState.favorites.contains(pair)
      ? Icons.favorite
      : Icons.favorite_border;

		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					BigCard(pair: pair),
					SizedBox(height: 10),
					Row(
            mainAxisSize: MainAxisSize.min,
						mainAxisAlignment: MainAxisAlignment.center,
					  children: [
					    ElevatedButton(
								onPressed: () => appState.getNext(),
								child: Text('Next LALA'),
							),
							SizedBox(width: 10),
					    ElevatedButton.icon(
					    	onPressed: () => appState.toggleFavorite(),
					    	label: Text('Like'),
                icon: Icon(icon)
					    ),
					  ],
					),
				]
			)
		);
	}
}


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
		final theme = Theme.of(context);
		final style = theme.textTheme.displayMedium!.copyWith(
			color: theme.colorScheme.onPrimary
		);

		return Center(
			child: Card(
				color: theme.colorScheme.primary,
				child: Padding(
					padding: const EdgeInsets.all(20),
					child: Text
					(
						pair.asPascalCase,
						style: style,
						semanticsLabel: "${pair.first} ${pair.second}",
					),
				),
			),
		);
	}
}