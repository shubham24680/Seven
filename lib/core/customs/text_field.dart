import 'package:seven/app/app.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.black4.withAlpha(150),
          label: CustomText(text: "Name", weight: FontWeight.w900),
          errorBorder: buildBorder(AppColors.red1),
          focusedBorder: buildBorder(AppColors.black1),
          enabledBorder: buildBorder(AppColors.black1.withAlpha(70))),
    );
  }

  InputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(0.01.sh),
    );
  }
}
