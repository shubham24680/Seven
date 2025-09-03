import 'package:flutter/material.dart';
import 'package:seven/core/utils/colors.dart';
import 'package:seven/core/custom/text.dart';
import 'package:seven/app/mobile/details.dart';
import 'package:seven/features/view/Details/details.dart';
import 'package:seven/features/view_model/search_provider.dart';
import 'package:provider/provider.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.crossCount});

  final int crossCount;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, value, __) {
        final shows = value.searchedShows;

        if (value.searchController.text.isEmpty || shows.isEmpty) {
          return Center(
            child: Text(
              value.searchController.text.isEmpty ? "" : "No results found!",
              style: TextStyle(color: grey),
            ),
          );
        }

        final double aspectRatio = 0.6;
        final double boxHeight = 200;
        final int rowCount = (shows.length / crossCount).ceil();

        return SizedBox(
          height: (boxHeight * rowCount) / aspectRatio,
          child: GridView.builder(
            itemCount: shows.length,
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              mainAxisSpacing: 30,
              crossAxisSpacing: 10,
              childAspectRatio: aspectRatio,
            ),
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
                    CustomText(
                      text: show.title,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: show.summary,
                      size: 10,
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
