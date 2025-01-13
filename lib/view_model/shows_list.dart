import 'package:flutter/material.dart';
import 'package:netflix/core/utils/texts.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/view/Details/details.dart';

class ShowList extends StatelessWidget {
  const ShowList({super.key, required this.shows});

  final List<Item> shows;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: shows.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10),
        itemBuilder: (_, index) {
          final show = shows[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(show: show),
              ),
            ),
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(top: 5, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(show.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Quicksand(text: show.title, weight: FontWeight.bold),
                  Quicksand(
                    text: show.summary,
                    size: 10,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
