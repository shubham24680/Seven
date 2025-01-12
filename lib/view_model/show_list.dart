import 'package:flutter/material.dart';
import 'package:netflix/core/utils/texts.dart';
import 'package:netflix/model/item.dart';

class ShowList extends StatelessWidget {
  const ShowList({super.key, required this.genre});

  final List<Item> genre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: genre.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10),
        itemBuilder: (_, index) {
          final show = genre[index];
          return Container(
            width: 200,
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(show.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Quicksand(text: show.title, size: 16, weight: FontWeight.bold),
                Quicksand(
                  text: show.summary,
                  maxLines: 3,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
