import 'package:seven/app/app.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(() => context.pop(), "Details"),
        body: const Center(
          child: CustomText(text: "Detail"),
        ));
  }
}
