import 'package:seven/app/app.dart';

enum TextFieldType { INPUT, DROPDOWN }

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.textFieldType = TextFieldType.INPUT,
      this.controller,
      this.filled,
      this.fillColor,
      this.labelText,
      this.hintText,
      this.hintColor,
      this.errorText,
      this.floatingHintColor,
      this.errorColor,
      this.suffixIconColor,
      this.suffixIcon,
      this.keyboardType,
      this.items = const [],
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.initialValue});

  final TextFieldType textFieldType;
  final TextEditingController? controller;
  final bool? filled;
  final bool readOnly;
  final Color? fillColor;
  final Color? hintColor;
  final Color? floatingHintColor;
  final Color? errorColor;
  final Color? suffixIconColor;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? suffixIcon;
  final String? initialValue;
  final List<String> items;
  final TextInputType? keyboardType;
  final void Function(String?)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final defaultColor = AppColors.lightSteel1.withAlpha(40);

    final decoration = InputDecoration(
        filled: filled,
        fillColor: fillColor ?? AppColors.lightSteel1.withAlpha(20),
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        labelStyle: buildHint(hintColor).getTextStyle(),
        floatingLabelStyle: buildHint(floatingHintColor).getTextStyle(),
        hintStyle: buildHint(hintColor).getTextStyle(),
        errorStyle: buildHint(errorColor).getTextStyle(),
        suffixIcon: buildIcon(suffixIcon, suffixIconColor),
        errorBorder: buildBorder(AppColors.red1),
        focusedBorder: buildBorder(AppColors.vividNightfall4),
        enabledBorder: buildBorder(defaultColor));

    final dropDownMenu = items
        .map((value) => DropdownMenuItem(
            value: value, child: buildHint(AppColors.lightSteel1, text: value)))
        .toList();

    Widget field;
    switch (textFieldType) {
      case TextFieldType.DROPDOWN:
        field = DropdownButtonFormField(
            items: dropDownMenu,
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: decoration,
            style: buildHint(AppColors.lightSteel1).getTextStyle(),
            hint: buildHint(hintColor, text: hintText),
            dropdownColor: AppColors.vividNightfall4,
            borderRadius: BorderRadius.circular(0.01.sh));
        break;
      default:
        field = TextFormField(
          controller: controller,
          onTap: onTap,
          decoration: decoration,
          readOnly: readOnly,
          keyboardType: keyboardType ?? TextInputType.text,
          style: buildHint(AppColors.lightSteel1).getTextStyle(),
          cursorColor: AppColors.vividNightfall4,
          cursorErrorColor: AppColors.red1,
        );
        break;
    }

    return field;
  }

  CustomText buildHint(Color? color, {String? text}) {
    return CustomText(
        text: text ?? "",
        color: color ?? AppColors.lightSteel1.withAlpha(40),
        weight: FontWeight.w900);
  }

  Widget buildIcon(String? icon, Color? color) {
    if (icon == null) return SizedBox.shrink();

    return CustomImage(
      imageType: ImageType.SVG_LOCAL,
      imageUrl: icon,
      color: color ?? AppColors.lightSteel1.withAlpha(40),
    ).paddingAll(0.01.sh);
  }

  InputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(0.01.sh),
    );
  }
}
