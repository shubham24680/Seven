import 'package:seven/app/app.dart';

enum ButtonType { ELEVATED, ICON, TEXT }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.buttonType,
      this.blurValue = 4.0,
      this.onPressed,
      this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      required this.child});

  final ButtonType? buttonType;
  final double blurValue;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final widgetBackgroundColor =
        backgroundColor ?? AppColors.lightSteel1.withAlpha(20);
    final widgetBorderRadius = BorderRadius.circular(borderRadius ?? 0.01.sh);

    Size? getSize() {
      if (height != null && width != null) {
        return Size(width!, height!);
      } else if (height != null) {
        return Size.fromHeight(height!);
      } else if (width != null) {
        return Size.fromWidth(width!);
      }

      return null;
    }

    Widget baseButton;
    switch (buttonType) {
      case ButtonType.ELEVATED:
        baseButton = ElevatedButton(
            onPressed: onPressed ?? () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: widgetBackgroundColor,
                minimumSize: getSize(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: widgetBackgroundColor),
                    borderRadius: widgetBorderRadius)),
            child: child);
        break;
      case ButtonType.TEXT:
        baseButton = TextButton(
            onPressed: onPressed ?? () {},
            style: TextButton.styleFrom(
                backgroundColor: widgetBackgroundColor,
                shape:
                    RoundedRectangleBorder(borderRadius: widgetBorderRadius)),
            child: child);
        break;
      case ButtonType.ICON:
        baseButton = IconButton(
          onPressed: onPressed ?? () {},
          icon: child,
        );
        break;
      default:
        baseButton = const SizedBox.shrink();
        break;
    }

    return blurEffect(
      blurValue,
      baseButton,
      borderRadius: widgetBorderRadius,
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, this.onTap});

  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return blurEffect(
        3,
        GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.black5.withAlpha(70),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                icon,
                height: 32,
                colorFilter: ColorFilter.mode(
                    AppColors.lightSteel1.withAlpha(200), BlendMode.srcIn),
              )),
        ),
        borderRadius: BorderRadius.circular(100));
  }
}
