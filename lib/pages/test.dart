import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class TestingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var i = 0;

    var listView = ListView.builder(
      addAutomaticKeepAlives: true,
      itemBuilder: (_, i) {
        return Container(
          color: Colors.primaries[i%17],
          width: 400,
          height: 100,
        );
      },
    );

    var carouselSlider = CarouselSlider(
      options: CarouselOptions(height: MediaQuery.of(context).size.height),
      items: [
        for (var pair in appState.favorites)
          Container(
            color: Colors.primaries[i++],
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text(pair.asPascalCase)),
          )
      ],
    );

    return Random().nextBool()
      ? listView
      : carouselSlider;
  }
}