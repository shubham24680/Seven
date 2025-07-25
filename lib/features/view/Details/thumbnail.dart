import 'package:flutter/material.dart';

Widget thumbnail(String url) {
  return // Thumbnail
      Container(
    height: 220,
    width: 150,
    margin: const EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: NetworkImage(url),
        fit: BoxFit.cover,
      ),
    ),
  );
}
