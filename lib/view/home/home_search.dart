import 'package:flutter/material.dart';
import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/core/widgets/texts.dart';
import 'package:netflix/view_model/shows_provider.dart';
import 'package:provider/provider.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ShowsProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => prov.setIndex(1),
      child: Container(
        height: 35,
        width: 300,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: darkGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: grey),
            SizedBox(width: 5),
            Quicksand(
              text: "Search Shows, Animation...",
              color: grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
