import 'package:seven/app/app.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildGenres() {
      final genres = AppConstants.GENRES;

      return Flexible(
          child: CustomCollection(
        cardType: CardType.GENRE,
        scrollDirection: Axis.vertical,
        isSafeHeight: true,
        isLoading: false,
        crossAxisCount: 2,
        loadingItemCount: genres.length,
        results: genres,
        screenPath: "/genreCollection/",
      ));
    }

    return SafeArea(
        child: Column(children: [
      CustomTextField(
              filled: true,
              readOnly: true,
              hintText: "Search movies",
              onTap: () => context.push("/searchCollection"),
              perfixIcon: CustomImage(
                  imageType: ImageType.SVG_LOCAL,
                  imageUrl: AppSvgs.SEARCH_OUTLINED,
                  color: AppColors.lightSteel1.withAlpha(40)))
          .paddingAll(AppConstants.SIDE_PADDING),
      buildGenres()
    ]));
  }
}
