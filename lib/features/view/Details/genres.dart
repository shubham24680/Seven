import 'package:flutter/material.dart';
import 'package:seven/core/custom/text.dart';

Widget genres(List<dynamic> showGenres) {
  return // Genres
      Wrap(
    children: List.generate(
      showGenres.length,
      (index) => Wrap(
        children: [
          CustomText(
            text: showGenres[index],
            weight: FontWeight.normal,
          ),
          if (index < showGenres.length - 1) CustomText(text: " • "),
        ],
      ),
    ),
  );
}
