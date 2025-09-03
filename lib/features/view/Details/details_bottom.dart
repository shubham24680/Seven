import 'package:flutter/material.dart';
import 'package:seven/core/custom/buttons/icon_buttons.dart';
import 'package:seven/core/custom/text.dart';
import 'package:seven/model/item.dart';
import 'package:seven/features/view/Details/text_tile.dart';
import 'package:seven/features/view/home/heading.dart';
import 'package:seven/features/view_model/shows_list.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({super.key, required this.show});

  final Item show;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary
        CustomText(
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

        Row(
          children: [
            IButton(icons: Icons.thumb_up_rounded),
            SizedBox(width: 20),
            IButton(icons: Icons.share),
          ],
        ),
        SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Heading(text: "More Like This"),
        ),
        ShowList(),
      ],
    );
  }
}
