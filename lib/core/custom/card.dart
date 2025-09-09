import 'package:seven/app/app.dart';

class CustomGenre extends StatelessWidget {
  const CustomGenre({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemBuilder: (context, index) => Container(
              height: 100,
              width: 200,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/one_piece.jpg"),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
      ],
    );
  }
}
