import 'package:flutter/material.dart';
import 'package:netflix/core/utils/texts.dart';
import 'package:netflix/model/item.dart';

class ShowList extends StatelessWidget {
  const ShowList({super.key, required this.shows});

  final List<Item> shows;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // itemCount: 10,
      itemCount: shows.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 20,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (_, index) {
        final show = shows[index];
        return GestureDetector(
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const Details(),
          //   ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Image.network(show.imageUrl ??
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FMandalorian_%2528character%2529&psig=AOvVaw1X5L0aobRngShamEr-Cfgd&ust=1736793004954000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjdhqLo8IoDFQAAAAAdAAAAABAJ"),
                ),
              ),
              SizedBox(height: 10),
              // Quicksand(text: "Joker", size: 16, weight: FontWeight.bold),
              Quicksand(text: show.title!, size: 16, weight: FontWeight.bold),
              Quicksand(
                // text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
                //     ". Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut"
                //     " felis non accumsan accumsan quis. Massa, id ut ipsum aliquam"
                //     " enim non posuere pulvinar diam.",
                text: show.summary!,
                maxLines: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
