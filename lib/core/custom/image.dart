import 'package:seven/app/app.dart';

class CustomImage extends StatelessWidget {
  CustomImage({
    super.key,
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    this.placeholder,
    this.fit,
  });

  final String? imageUrl;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
            imageUrl: ApiConstants.IMAGE_PATH + (imageUrl ?? ""),
            placeholder:
                (placeholder != null) ? (context, url) => placeholder! : null,
            errorWidget: (context, url, error) => errorWidget,
            fit: fit ?? BoxFit.cover));
  }

  SizedBox errorWidget = SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Image.asset(
      "assets/images/placeholder_image.png",
      fit: BoxFit.cover,
    ),
  );
}
