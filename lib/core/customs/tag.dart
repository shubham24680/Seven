import 'package:seven/app/app.dart';

enum TagType { FILLED, OUTLINED }

enum TagSize { LARGE, MEDIUM, SMALL }

class CustomTag extends StatelessWidget {
  const CustomTag(
      {super.key,
      this.tagType = TagType.FILLED,
      this.tagSize = TagSize.MEDIUM,
      this.icon,
      this.value,
      this.color,
      this.backgroundColor});

  final TagType tagType;
  final TagSize tagSize;
  final String? icon;
  final String? value;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    double height;
    switch (tagSize) {
      case TagSize.LARGE:
        height = 0.022.sh;
        break;
      case TagSize.SMALL:
        height = 0.014.sh;
        break;
      default:
        height = 0.018.sh;
        break;
    }

    final outlined = tagType == TagType.OUTLINED;
    final borderRadius = BorderRadius.circular(height);
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
        height: height,
        color: color ?? AppColors.lightSteel1);
    final tagChild = Container(
        padding: EdgeInsets.symmetric(
            horizontal: 0.5 * height, vertical: 0.2 * height),
        decoration: decoration,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) image,
          if (icon != null && value != null) const SizedBox(width: 5),
          if (value != null)
            CustomText(
                text: value ?? "",
                size: 0.9 * height,
                color: color,
                weight: icon == null ? FontWeight.w900 : null)
        ]));

    return outlined
        ? tagChild
        : blurEffect(6.0, tagChild, borderRadius: borderRadius);
  }
}
