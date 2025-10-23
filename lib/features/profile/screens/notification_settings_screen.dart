import 'package:seven/app/app.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(() => context.pop(), "Notification Settings"),
      body: Center(
        child: CustomText(text: "Notification Settings"),
      ),
    );
  }
}
