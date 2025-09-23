import 'package:seven/app/app.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: CustomButton(
              buttonType: ButtonType.ICON,
              icon: AppIcons.REMOVE_TO_FAVOURITE,
              backgroundColor: AppColors.lightSteel9,
              onPressed: () => context.pop(),
            ),
            centerTitle: true,
            title: const CustomText(
                text: "Notifications", weight: FontWeight.w900)),
        body: const Center(
          child: CustomText(text: "No Notification"),
        ));
  }
}
