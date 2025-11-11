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
      this.keyboardType,
      this.items = const [],
      this.onChanged,
      this.readOnly = false,
      this.autofocus = false,
      this.onTap,
      this.initialValue,
      this.perfixIcon,
      this.suffixIcon});

  final TextFieldType textFieldType;
  final TextEditingController? controller;
  final bool? filled;
  final bool readOnly;
  final bool autofocus;
  final Color? fillColor;
  final Color? hintColor;
  final Color? floatingHintColor;
  final Color? errorColor;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final List<String> items;
  final TextInputType? keyboardType;
  final Widget? perfixIcon;
  final Widget? suffixIcon;
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
        prefixIcon: perfixIcon?.paddingAll(0.01.sh),
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
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
            value: initialValue,
            onChanged: onChanged,
            decoration: decoration,
            style: buildHint(AppColors.lightSteel1).getTextStyle(),
            hint: buildHint(hintColor, text: hintText),
            dropdownColor: AppColors.vividNightfall4,
            borderRadius: BorderRadius.circular(0.015.sh));
        break;
      default:
        field = TextFormField(
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          decoration: decoration,
          readOnly: readOnly,
          autofocus: autofocus,
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

  InputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(0.015.sh),
    );
  }
}
