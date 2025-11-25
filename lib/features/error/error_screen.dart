import 'package:seven/app/app.dart';

enum Type { TYPE1, TYPE2 }

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
      {super.key,
      this.onPressed,
      this.goBack = false,
      this.type = Type.TYPE1,
      this.heading,
      this.description,
      this.image});

  final Type type;
  final void Function()? onPressed;
  final bool goBack;
  final String? image;
  final String? heading;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final errorData = AppConstants.ERRORDATA;
    final topPadding = MediaQuery.of(context).padding.top;

    final title = CustomText(
        text: heading ?? errorData.string1 ?? "",
        family: AppFonts.STAATLICHES,
        size: 0.04.sh);
    final desc = CustomText(
        text: description ?? errorData.string2 ?? "", size: 0.015.sh);
    final img = CustomImage(
        imageType: ImageType.SVG_LOCAL, imageUrl: image ?? errorData.string3);
    final triggerButtons = Column(children: [
      if (onPressed != null) buildButton(errorData.string4, onTap: onPressed),
      if (!goBack) ...[
        SizedBox(height: 0.01.sh),
        buildButton(errorData.string5,
            color: AppColors.lightSteel1.withAlpha(40),
            onTap: () => context.pop())
      ]
    ]);

    Widget screenType;
    switch (type) {
      case Type.TYPE2:
        screenType =
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          img,
          SizedBox(height: 0.02.sh),
          title,
          CustomText(
              text: description ?? errorData.string2 ?? "",
              size: 0.015.sh,
              align: TextAlign.center),
          SizedBox(height: 0.1.sh),
          if (onPressed == null || !goBack) triggerButtons
        ]);
        break;
      default:
        screenType = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, desc]),
              img,
              if (onPressed != null || !goBack) triggerButtons
            ]);
    }

    return screenType.paddingFromLTRB(
        left: AppConstants.SIDE_PADDING,
        right: AppConstants.SIDE_PADDING,
        top: topPadding);
  }

  Widget buildButton(String? value,
      {Color color = AppColors.vividNightfall4, Function()? onTap}) {
    if (value == null) return SizedBox.shrink();

    return CustomButton(
        buttonType: ButtonType.ELEVATED,
        backgroundColor: color,
        height: 0.065.sh,
        onPressed: onTap,
        child: CustomText(text: value, weight: FontWeight.w900));
  }
}
