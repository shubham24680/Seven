import 'package:flutter/material.dart';
import 'package:seven/core/custom/text.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CustomText(
        text: text,
        size: 16,
      ),
    );
  }
}
