import 'package:flutter/material.dart';
import 'package:seven/core/utils/colors.dart';

class IButton extends StatelessWidget {
  const IButton({super.key, required this.icons, this.onpressed});

  final IconData icons;
  final Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed ?? () {},
      icon: Icon(icons, color: white),
    );
  }
}
