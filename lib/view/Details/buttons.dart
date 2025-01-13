import 'package:flutter/material.dart';
import 'package:netflix/core/utils/colors.dart';
import 'package:netflix/core/widgets/icon_buttons.dart';
import 'package:netflix/core/widgets/texts.dart';

Align closeButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: IButton(
      icons: Icons.close_rounded,
      onpressed: () => Navigator.pop(context),
    ),
  );
}

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
        fixedSize: Size(400, 40),
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

// Play
dynamic get play => EButton(
      backgroundColor: white,
      forgroundColor: black,
      icons: Icons.play_arrow_rounded,
      text: "Play",
    );

// My List
dynamic get myList => EButton(
      backgroundColor: grey,
      forgroundColor: white,
      icons: Icons.add,
      text: "My List",
    );
