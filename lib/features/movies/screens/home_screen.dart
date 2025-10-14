import 'package:seven/app/app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      const HomeCarousel(),
      SizedBox(height: 0.02.sh),
      Consumer(builder: (_, ref, __) {
        final showsState = ref.watch(showsProvider);

        return Column(
            children: List.generate(AppConstants.COLLECTIONS.length, (index) {
          final collection = showsState.collection[index];
          final isLoading = collection.isLoading;
          final isError = collection.isError;

          if (isError ||
              (!isLoading && collection.results?.firstOrNull == null)) {
            return const SizedBox.shrink();
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (index != 0)
                  const Divider(
                    color: AppColors.black2,
                  ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                CustomCard(
                    orientation: CardOrientation.LANDSCAPE,
                    result: collection.results?[1]),
                const SizedBox(height: 50),
                CustomCard(
                    orientation: CardOrientation.POTRAIT,
                    result: collection.results?[1]),
                const SizedBox(height: 50),
                CustomCard(
                    orientation: CardOrientation.LANDSCAPE,
                    isGenreCard: true,
                    imageUrl: "assets/images/one_piece.jpg",
                    title: "Anime",
                    height: 0.25.sh,
                    result: collection.results?[1]),
                const SizedBox(height: 50),
                CustomCard(
                    orientation: CardOrientation.LANDSCAPE,
                    isGenreCard: true,
                    imageUrl: "assets/images/t2.jpg",
                    title: "Science fiction",
                    height: 0.25.sh,
                    result: collection.results?[1]),
                const SizedBox(height: 50),
                CustomCard(
                  orientation: CardOrientation.POTRAIT,
                  isGenreCard: true,
                  imageUrl: "assets/images/one_piece.jpg",
                  title: "Anime",
                ),
                CustomCollection(
                  collectionName: AppConstants.COLLECTIONS[index],
                  isLoading: isLoading,
                  result: collection.results,
                )
              ]);
        }));
      })
    ]));
  }
}
