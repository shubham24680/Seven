import 'package:seven/app/app.dart';

enum ErrorType { NO_INTERNET, NO_DATA }

enum Type { TYPE_1, TYPE_2 }

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
      {super.key,
      this.onPressed,
      this.goBack = true,
      this.errorType = ErrorType.NO_INTERNET,
      this.type = Type.TYPE_1,
      this.errorData});

  final ErrorType errorType;
  final Type type;
  final void Function()? onPressed;
  final bool goBack;
  final HelperModel? errorData;

  HelperModel get _data => switch (errorType) {
        ErrorType.NO_DATA => AppConstants.NO_DATA,
        ErrorType.NO_INTERNET => AppConstants.NO_INTERNET,
      };

  @override
  Widget build(BuildContext context) {
    final data = errorData ?? _data;

    final titleWidget = CustomText(
      text: data.string1 ?? "",
      family: AppFonts.STAATLICHES,
      size: 0.04.sh,
    );

    final imgWidget = CustomImage(
      imageType: ImageType.SVG_LOCAL,
      imageUrl: data.string3,
    );

    final triggerButtons = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onPressed != null) _buildButton(data.string4, onTap: onPressed),
        if (goBack) ...[
          SizedBox(height: 0.01.sh),
          _buildButton(
            data.string5,
            color: AppColors.lightSteel1.withAlpha(40),
            onTap: () => context.pop(),
          ),
        ],
      ],
    );

    final Widget screenContent = switch (type) {
      Type.TYPE_1 => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget,
                CustomText(text: data.string2 ?? "", size: 0.015.sh)
              ],
            ),
            imgWidget,
            if (onPressed != null || goBack) triggerButtons,
          ],
        ),
      Type.TYPE_2 => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgWidget,
            SizedBox(height: 20.w),
            titleWidget,
            CustomText(
              text: data.string2 ?? "",
              size: 0.015.sh,
              align: TextAlign.center,
            ),
            if (onPressed != null || goBack) ...[
              SizedBox(height: 100.w),
              triggerButtons
            ],
          ],
        ),
    };

    return screenContent.padding(
        horizontal: AppConstants.SIDE_PADDING,
        top: DimensionUtil().statusBarHeight);
  }

  Widget _buildButton(
    String? value, {
    Color color = AppColors.vividNightfall4,
    VoidCallback? onTap,
  }) {
    if (value == null) return const SizedBox.shrink();

    return CustomButton(
      buttonType: ButtonType.ELEVATED,
      backgroundColor: color,
      height: 0.065.sh,
      onPressed: onTap,
      child: CustomText(text: value, weight: FontWeight.w900),
    );
  }
}
