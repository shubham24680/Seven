import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven/core/custom/text.dart';
import 'package:seven/model/item.dart';
import 'package:seven/features/view/Details/buttons.dart';
import 'package:seven/features/view/Details/details_bottom.dart';
import 'package:seven/features/view/Details/genres.dart';
import 'package:seven/features/view/Details/thumbnail.dart';

class MobileDetails extends StatelessWidget {
  const MobileDetails({super.key, required this.show});

  final Item show;

  @override
  Widget build(BuildContext context) {
    log("${show.genres.length}");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              // Close button
              closeButton(context),

              // thumbnail
              thumbnail(show.imageUrl),
              SizedBox(height: 20),

              // Title
              CustomText(text: show.title, size: 24),
              genres(show.genres),
              SizedBox(height: 20),
              play,
              SizedBox(height: 5),
              myList,

              SizedBox(height: 10),

              DetailsBottom(show: show),
            ],
          ),
        ),
      ),
    );
  }
}
