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
      this.onTap,
      this.color});

  final ImageType imageType;
  final String? imageUrl;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final BoxFit? fit;
  final double? height;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Image localImage() {
      return Image.asset(
        imageUrl ?? AppImages.PLACEHOLDER,
        fit: fit ?? BoxFit.cover,
        height: height,
      );
    }

    Widget image;
    switch (imageType) {
      case ImageType.REMOTE:
        image = CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            placeholder:
                (placeholder != null) ? (context, url) => placeholder! : null,
            errorWidget: (context, url, error) => localImage(),
            fit: fit ?? BoxFit.cover,
            height: height);
        break;
      case ImageType.SVG_LOCAL:
        image = SvgPicture.asset(imageUrl ?? AppSvgs.STAR,
            height: height ?? 0.03.sh,
            fit: fit ?? BoxFit.contain,
            colorFilter: ColorFilter.mode(
                AppColors.lightSteel1.withAlpha(200), BlendMode.srcIn));
        break;
      default:
        image = localImage();
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: image,
      ),
    );
  }
}
