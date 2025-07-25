import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:seven/features/view_model/shows_provider.dart';
import 'package:seven/core/utils/colors.dart';

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ShowsProvider prov = Provider.of(context, listen: false);

    return Consumer<ShowsProvider>(
      builder: (_, value, __) {
        return BottomNavigationBar(
          backgroundColor: black,
          selectedItemColor: red,
          unselectedItemColor: grey,
          currentIndex: value.currentIndex,
          onTap: (index) => prov.setIndex(index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ],
        );
      },
    );
  }
}
