import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
	var favorites = <WordPair>[];
	var current = WordPair.random();

	void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

	void toggleFavorite() {
		favorites.contains(current) 
      ? favorites.remove(current)
      : favorites.add(current);
    
    notifyListeners();
	}
}