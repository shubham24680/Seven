import 'package:flutter/material.dart';
import 'package:seven/core/custom/text.dart';

class TextTile extends StatelessWidget {
  const TextTile({super.key, required this.question, required this.answer});

  final String question, answer;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          CustomText(
            text: question,
          ),
          CustomText(
            text: answer,
            weight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
