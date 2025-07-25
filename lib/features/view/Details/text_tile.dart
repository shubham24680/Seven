import 'package:flutter/material.dart';
import 'package:seven/core/common/texts.dart';

class TextTile extends StatelessWidget {
  const TextTile({super.key, required this.question, required this.answer});

  final String question, answer;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Quicksand(
            text: question,
          ),
          Quicksand(
            text: answer,
            weight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
