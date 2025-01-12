import 'package:flutter/material.dart';
import 'package:netflix/core/utils/colors.dart';

class Quicksand extends StatelessWidget {
  const Quicksand(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.weight,
      this.maxLines});

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Quicksand',
        color: color ?? white,
        fontSize: size ?? 12,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
