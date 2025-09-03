import 'package:seven/app/app.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.align,
    this.family,
    this.maxLines,
    this.color,
    this.size,
    this.weight,
    this.height,
  });

  final String text;
  final TextAlign? align;
  final int? maxLines;
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
      overflow: TextOverflow.fade,
      style: TextStyle(
        fontFamily: family ?? AppAssets.POPPINS,
        color: color,
        fontSize: size,
        fontWeight: weight,
        height: height,
      ),
    );
  }
}
