import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:netflix/view_model/shows_provider.dart';
import 'package:netflix/core/utils/colors.dart';

class LeftNavigationButton extends StatelessWidget {
  const LeftNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ShowsProvider prov = Provider.of(context, listen: false);

    return Consumer<ShowsProvider>(
      builder: (_, value, __) {
        return Column(
          children: [
            IconButton(
              onPressed: () => prov.setIndex(0),
              icon: Icon(
                Icons.home,
                color: prov.currentIndex == 0 ? red : white,
              ),
            ),
            SizedBox(height: 10),
            IconButton(
              onPressed: () => prov.setIndex(1),
              icon: Icon(
                Icons.search,
                color: prov.currentIndex == 1 ? red : white,
              ),
            ),
          ],
        );
      },
    );
  }
}
