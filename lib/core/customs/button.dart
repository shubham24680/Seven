import 'package:seven/app/app.dart';

enum ButtonType { ELEVATED, ICON, TEXT }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.buttonType = ButtonType.ELEVATED,
      this.blurValue = 3.0,
      this.onPressed,
      this.borderRadius,
      this.backgroundColor,
      this.forgroundColor,
      this.height,
      this.width,
      this.child,
      this.icon});

  final ButtonType buttonType;
  final double blurValue;
  final double? height;
  final double? width;
  final double? borderRadius;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? forgroundColor;
  final Widget? child;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final widgetBackgroundColor =
        backgroundColor ?? AppColors.lightSteel1.withAlpha(20);
    final widgetBorderRadius = BorderRadius.circular(
        borderRadius ?? (buttonType == ButtonType.ICON ? 1.sh : 0.015.sh));

    Size? getSize() {
      if (height != null && width != null) {
        return Size(width ?? 0, height ?? 0);
      } else if (height != null) {
        return Size.fromHeight(height ?? 0);
      } else if (width != null) {
        return Size.fromWidth(width ?? 0);
      }

      return null;
    }

    Widget baseButton;
    switch (buttonType) {
      case ButtonType.TEXT:
        baseButton = CustomText(
          text: icon ?? "",
          size: 0.015.sh,
          color: forgroundColor ?? AppColors.lightSteel1.withAlpha(150),
        ).onTap(event: onPressed ?? () {});
        break;
      case ButtonType.ICON:
        baseButton = IconButton(
            onPressed: onPressed,
            style: IconButton.styleFrom(
                backgroundColor:
                    backgroundColor ?? AppColors.black5.withAlpha(70),
                shape: const CircleBorder()),
            icon: SvgPicture.asset(icon ?? AppSvgs.HOME,
                height: height ?? 0.03.sh,
                colorFilter: ColorFilter.mode(
                    forgroundColor ?? AppColors.lightSteel1.withAlpha(200),
                    BlendMode.srcIn)));
        break;
      default:
        baseButton = ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: widgetBackgroundColor,
                minimumSize: getSize(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: onPressed == null
                            ? AppColors.lightSteel1.withAlpha(20)
                            : widgetBackgroundColor),
                    borderRadius: widgetBorderRadius)),
            child: child);
        break;
    }

    return blurEffect(
      blurValue,
      baseButton,
      borderRadius: widgetBorderRadius,
    );
  }
}
