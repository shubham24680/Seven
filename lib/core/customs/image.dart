import 'package:seven/app/app.dart';

enum ImageType { REMOTE, LOCAL, SVG_REMOTE, SVG_LOCAL }

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      this.imageType = ImageType.LOCAL,
      this.imageUrl,
      this.borderRadius = BorderRadius.zero,
      this.placeholder,
      this.fit,
      this.height});

  final ImageType imageType;
  final String? imageUrl;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final BoxFit? fit;
  final double? height;

  @override
  Widget build(BuildContext context) {
    print("CustomImage fit parameter: $fit");

    Image localImage() {
      return Image.asset(
        imageUrl ?? AppImages.PLACEHOLDER,
        fit: fit ?? BoxFit.cover,
      );
    }

    Widget image;
    switch (imageType) {
      case ImageType.REMOTE:
        image = ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                placeholder: (placeholder != null)
                    ? (context, url) => placeholder!
                    : null,
                errorWidget: (context, url, error) => localImage(),
                fit: fit ?? BoxFit.cover,
                height: height));
        break;
      case ImageType.SVG_LOCAL:
        image = SvgPicture.asset(
          imageUrl ?? AppSvgs.NO_CONNECTION,
          fit: fit ?? BoxFit.contain,
        );
        break;
      default:
        image = localImage();
        break;
    }

    return image;
  }
}
