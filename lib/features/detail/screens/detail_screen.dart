import 'package:seven/app/app.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: CustomButton(
              buttonType: ButtonType.ICON,
              icon: AppSvgs.REMOVE_TO_FAVOURITE,
              backgroundColor: AppColors.lightSteel9,
              onPressed: () => context.pop(),
            ),
            centerTitle: true,
            title: const CustomText(text: "Detail", weight: FontWeight.w900)),
        body: const Center(
          child: CustomText(text: "Detail"),
        ));
  }
}
