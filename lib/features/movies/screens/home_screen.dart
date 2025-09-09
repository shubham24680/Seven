import 'package:seven/app/app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/one_piece.jpg"),
          const CustomGenre(title: "Top 10 Movies"),
          const CustomGenre(title: "Top 10 TV shows"),
          const CustomGenre(title: "Apple TV+"),
          const CustomGenre(title: "Action"),
          const CustomGenre(title: "Adventure"),
        ],
      ),
    );
  }
}
