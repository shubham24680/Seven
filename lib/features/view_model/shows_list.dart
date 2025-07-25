import 'package:flutter/material.dart';
import 'package:seven/core/common/texts.dart';
import 'package:seven/app/mobile/details.dart';
import 'package:seven/features/view/Details/details.dart';
import 'package:seven/features/view_model/shows_provider.dart';
import 'package:provider/provider.dart';

class ShowList extends StatelessWidget {
  const ShowList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowsProvider>(
      builder: (_, value, __) {
        final shows = value.shows;
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
                    builder: (context) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 500) {
                            return MobileDetails(show: show);
                          } else if (constraints.maxWidth < 1100) {
                            return Details(show: show);
                          } else {
                            return Details(show: show);
                          }
                        },
                      );
                    },
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
      },
    );
  }
}
