import 'package:seven/app/app.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(() => context.pop(), "Help"),
      body: Center(
        child: CustomText(text: "Help"),
      ),
    );
  }
}
