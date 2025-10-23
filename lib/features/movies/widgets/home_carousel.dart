import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);
    final results = showsState.shows.results;
    final genres = showsState.genre.genres;

    final viewportFraction = 0.7;
    final width = 1.sw;
    final height = 1.5 * width;
    final carouselHeight = viewportFraction * height;

    String getGenre(int genreId) {
      final value = genres?.firstWhere(
        (gen) => gen.id == genreId,
        orElse: () => Genre(id: -1, name: null),
      );

      return value?.name ?? "";
    }

    Widget buildAppBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppImages.AVATAR_1,
            height: 0.048.sh,
            borderRadius: BorderRadius.circular(1.sh),
            event: () => showsController
                .moveToPage(AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1),
          ),
          CustomButton(
            buttonType: ButtonType.ICON,
            icon: AppSvgs.NOTIFICATION,
            onPressed: () => context.push("/notification"),
          ),
        ],
      );
    }

    Widget buildMainWidget() {
      final showGenre = getGenre(
          results?[showsState.carouselCurrentIndex].genreIds?[0] ?? -1);

      return blurEffect(
          6.0,
          Container(
              height: height,
              padding: EdgeInsets.fromLTRB(
                  0.05 * width, 0.02 * height, 0.05 * width, 0.0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.transparent, AppColors.black3])),
              child: SafeArea(
                  child: Column(children: [
                buildAppBar(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (genres?.firstOrNull != null)
                      Wrap(children: [
                        CustomText(
                          text: showGenre,
                          size: 0.025 * height,
                          weight: FontWeight.w900,
                        ),
                        CustomText(text: " • ")
                      ]),
                    CustomText(
                      text:
                          results?[showsState.carouselCurrentIndex].mediaType ??
                              "",
                      size: 0.025 * height,
                      weight: FontWeight.w900,
                      capitalFirstWord: true,
                    ),
                  ],
                ),
                SizedBox(height: 0.01 * height),
                CustomText(
                    text: results?[showsState.carouselCurrentIndex].overview ??
                        "",
                    size: 0.02 * height,
                    align: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis)
              ]))));
    }

    Widget buildCarouselChild(int index) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          CustomImage(
              imageType: ImageType.REMOTE,
              event: () => context.push("/detail"),
              imageUrl:
                  ApiConstants.IMAGE_PATH + (results?[index].posterPath ?? ""),
              borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
          if (results?[index].voteAverage != null)
            IgnorePointer(
                child: customTag(AppSvgs.STAR,
                        (results?[index].voteAverage ?? 0.0).toStringAsFixed(1))
                    .paddingAll(0.05 * carouselHeight)),
        ],
      );
    }

    Widget buildCarousel() {
      return CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) => buildCarouselChild(index),
          itemCount: results?.length ?? 0,
          options: CarouselOptions(
              onPageChanged: (index, _) => showsController.nextTo(index),
              initialPage: showsState.carouselCurrentIndex,
              height: carouselHeight,
              viewportFraction: viewportFraction,
              autoPlay: true,
              enlargeCenterPage: true));
    }

    if (showsState.shows.isSuccess) {
      return Stack(alignment: Alignment.center, children: [
        CustomImage(
            imageType: ImageType.REMOTE,
            imageUrl: ApiConstants.IMAGE_PATH +
                (results?[showsState.carouselCurrentIndex].posterPath ?? ""),
            height: height),
        buildMainWidget(),
        buildCarousel()
      ]);
    }

    debugPrint(
        "${showsState.shows.apiStatus} -> ${showsState.shows.errorMessage}");
    return Stack(
      children: [
        if (showsState.shows.isLoading) customShimmer(height: height),
        SafeArea(child: buildAppBar().paddingAll(AppConstants.SIDE_PADDING))
      ],
    );
  }
}
