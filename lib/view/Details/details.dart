import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/core/utils/icon_buttons.dart';
import 'package:netflix/core/utils/texts.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/view/Details/buttons.dart';
import 'package:netflix/view/Details/text_tile.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.show});

  final Item show;

  @override
  Widget build(BuildContext context) {
    log("${show.genres.length}");
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.centerRight,
                    child: IButton(
                      icons: Icons.close_rounded,
                      onpressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Thumbnail
                  Container(
                    height: 220,
                    width: 150,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(show.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Title
                  Quicksand(text: show.title, size: 24),

                  // Genres
                  Wrap(
                    children: List.generate(
                      show.genres.length,
                      (index) => Wrap(
                        children: [
                          Quicksand(
                            text: "${show.genres[index]}",
                            weight: FontWeight.normal,
                          ),
                          if (index < show.genres.length - 1)
                            Quicksand(text: " • "),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),

                  // Play
                  EButton(
                    backgroundColor: white,
                    forgroundColor: black,
                    icons: Icons.play_arrow_rounded,
                    text: "Play",
                  ),
                  SizedBox(height: 5),

                  // My List
                  EButton(
                    backgroundColor: grey,
                    forgroundColor: white,
                    icons: Icons.add,
                    text: "My List",
                  ),
                  SizedBox(height: 10),

                  // Summary
                  Quicksand(
                    maxLines: 10,
                    text: show.summary,
                    // text: "To create a BottomNavigationBar in Flutter using the"
                    //     " Provider package, you can separate the logic for"
                    //     " managing the selected index and the UI for the"
                    //     " navigation bar. Below is a complete example "
                    //     "To create a BottomNavigationBar in Flutter using the"
                    //     " Provider package, you can separate the logic for"
                    //     " managing the selected index and the UI for the"
                    //     " navigation bar. Below is a complete example.",
                    weight: FontWeight.normal,
                    size: 10,
                  ),
                  SizedBox(height: 5),

                  //Language
                  TextTile(question: "Type: ", answer: show.type),
                  SizedBox(height: 5),

                  //Language
                  TextTile(question: "Language: ", answer: show.language),
                  SizedBox(height: 5),

                  //Premiered
                  TextTile(question: "Premiered: ", answer: show.premiered),
                  SizedBox(height: 5),

                  //Duration
                  TextTile(question: "Duration: ", answer: "${show.runtime}m"),
                  SizedBox(height: 5),

                  //Status
                  TextTile(question: "Status: ", answer: show.status),
                  SizedBox(height: 5),

                  //Status
                  TextTile(question: "Rating: ", answer: "${show.rating}/10"),
                  SizedBox(height: 5),
                ],
              ),

              // Icons
              Row(
                children: [
                  IButton(icons: Icons.thumb_up_rounded),
                  SizedBox(width: 20),
                  IButton(icons: Icons.share),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
