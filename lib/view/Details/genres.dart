import 'package:flutter/material.dart';
import 'package:netflix/core/widgets/texts.dart';

Widget genres(List<dynamic> showGenres) {
  return // Genres
      Wrap(
    children: List.generate(
      showGenres.length,
      (index) => Wrap(
        children: [
          Quicksand(
            text: showGenres[index],
            weight: FontWeight.normal,
          ),
          if (index < showGenres.length - 1) Quicksand(text: " • "),
        ],
      ),
    ),
  );
}
