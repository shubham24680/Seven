import 'package:seven/app/app.dart';

enum TagType { FILLED, OUTLINED }

class CustomTag extends StatelessWidget {
  const CustomTag(
      {super.key,
      this.tagType = TagType.FILLED,
      this.icon,
      this.value,
      this.color,
      this.backgroundColor});

  final TagType tagType;
  final String? icon;
  final String? value;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final outlined = tagType == TagType.OUTLINED;
    final borderRadius = BorderRadius.circular(0.02.sh);
    final decoration = BoxDecoration(
        color: outlined
            ? AppColors.transparent
            : backgroundColor ?? AppColors.vividNightfall4,
        borderRadius: borderRadius,
        border:
            Border.all(color: backgroundColor ?? AppColors.vividNightfall4));
    final image = CustomImage(
        imageType: ImageType.SVG_LOCAL,
        imageUrl: icon,
        height: 0.02.sh,
        color: color ?? AppColors.lightSteel1);
    final tagChild = Container(
        padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.005.sh),
        decoration: decoration,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) image,
          if (icon != null && value != null) const SizedBox(width: 5),
          if (value != null)
            CustomText(
                text: value ?? "",
                size: 0.015.sh,
                color: color,
                weight: icon == null ? FontWeight.w900 : null)
        ]));

    return outlined
        ? tagChild
        : blurEffect(6.0, tagChild, borderRadius: borderRadius);
  }
}
