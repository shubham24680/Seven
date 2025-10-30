import 'package:seven/app/app.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(() => context.pop(), "Notifications"),
        body: const Center(
          child: CustomText(text: "No Notification"),
        ));
  }
}
