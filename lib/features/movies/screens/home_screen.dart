import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);

    return Builder(builder: (context) {
      if (showsState.status.isLoading) {
        return Center(child: CircularProgressIndicator(color: vividNightfall4));
      }

      if (showsState.status.isError) {
        return Center(
            child:
                CustomText(text: "Error -> ${showsState.status.errorMessage}"));
      }

      if (showsState.status.isInitial) {
        Future.microtask(() {
          showsController.loadShows();
        });
        return const Center(child: CustomText(text: "Initial"));
      }

      if (showsState.status.isEmpty) {
        return const Center(child: CustomText(text: "Empty"));
      }

      return Center(
        child: (showsState.shows.results == null)
            ? CustomText(
                text: "Success -> ${showsState.status.successMessage}",
              )
            : CustomText(
                text: "Title -> ${showsState.shows.results?[0].originalTitle}"),
      );
    });

    // return SingleChildScrollView(child:
    // Column(
    //   children: [
    //     Image.asset("assets/images/one_piece.jpg"),
    //     const CustomGenre(title: "Top 10 Movies"),
    //     const CustomGenre(title: "Top 10 TV shows"),
    //     const CustomGenre(title: "Apple TV+"),
    //     const CustomGenre(title: "Action"),
    //     const CustomGenre(title: "Adventure"),
    //   ],
    // ),
    // );
  }
}
