import 'package:flutter/material.dart';
import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/core/utils/texts.dart';

class EButton extends StatelessWidget {
  const EButton({
    super.key,
    required this.backgroundColor,
    required this.forgroundColor,
    required this.icons,
    required this.text,
  });

  final Color backgroundColor;
  final Color forgroundColor;
  final IconData icons;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: black,
        minimumSize: Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Wrap(
        children: [
          Icon(icons, color: forgroundColor),
          SizedBox(width: 5),
          Quicksand(text: text, color: forgroundColor),
        ],
      ),
    );
  }
}
