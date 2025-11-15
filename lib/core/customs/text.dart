import 'package:seven/app/app.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.align,
      this.maxLines,
      this.overflow,
      this.family,
      this.color,
      this.size,
      this.weight,
      this.height,
      this.capitalFirstWord = false});

  final String text;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? family;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final double? height;
  final bool capitalFirstWord;

  @override
  Widget build(BuildContext context) {
    final words = capitalFirstWord && text.isNotEmpty
        ? "${text[0].toUpperCase()}${text.substring(1)}"
        : text;

    return Text(
      words,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: getTextStyle(),
    );
  }

  TextStyle getTextStyle() {
    return TextStyle(
      fontFamily: family ?? AppFonts.POPPINS,
      color: color,
      fontSize: size ?? 0.02.sh,
      fontWeight: weight,
      height: height,
    );
  }
}
