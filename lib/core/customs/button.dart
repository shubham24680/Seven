import 'package:seven/app/app.dart';

enum ButtonType { ELEVATED, ICON, TEXT }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.buttonType,
      this.blurValue = 3.0,
      this.onPressed,
      this.backgroundColor,
      this.height,
      this.width,
      this.borderRadius,
      this.child,
      this.icon});

  final ButtonType? buttonType;
  final double blurValue;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;
  final String? icon;

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
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: widgetBackgroundColor,
                minimumSize: getSize(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: onPressed == null
                            ? AppColors.lightSteel8
                            : widgetBackgroundColor),
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
            child: const CustomText(text: "No Button"));
        break;
      case ButtonType.ICON:
        baseButton = IconButton(
            onPressed: onPressed ?? () {},
            style: IconButton.styleFrom(
                backgroundColor: backgroundColor, shape: const CircleBorder()),
            icon: SvgPicture.asset(
              icon ?? AppIcons.HOME,
              height: 0.04.sh,
              colorFilter: ColorFilter.mode(
                  AppColors.lightSteel1.withAlpha(200), BlendMode.srcIn),
            ));
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
