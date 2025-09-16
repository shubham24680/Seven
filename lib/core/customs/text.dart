import 'package:seven/app/app.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.align,
    this.maxLines,
    this.overflow,
    this.family,
    this.color,
    this.size,
    this.weight,
    this.height,
  });

  final String text;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? family;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      style: TextStyle(
        fontFamily: family ?? AppAssets.POPPINS,
        color: color,
        fontSize: size ?? 0.02.sh,
        fontWeight: weight,
        height: height,
      ),
    );
  }
}
