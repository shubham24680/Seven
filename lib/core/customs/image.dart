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
      this.height,
      this.width,
      this.event,
      this.color});

  final ImageType imageType;
  final String? imageUrl;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final void Function()? event;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Image localImage = Image.asset(
      imageUrl ?? AppImages.PLACEHOLDER,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
    );

    Widget image;
    switch (imageType) {
      case ImageType.REMOTE:
        image = CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            placeholder: (context, url) =>
                (placeholder != null) ? placeholder! : customShimmer(),
            errorWidget: (context, url, error) => localImage,
            fit: fit ?? BoxFit.cover,
            height: height,
            width: width);
        break;
      case ImageType.SVG_LOCAL:
        image = SvgPicture.asset(imageUrl ?? AppSvgs.STAR,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: (color != null)
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null);
        break;
      case ImageType.LOCAL:
      default:
        image = localImage;
        break;
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: image,
    ).onTap(event: event);
  }
}
