import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileIndex = ref.watch(profileProvider).profilePicIndex;
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
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppAssets.AVATARS[profileIndex],
            height: 0.048.sh,
            borderRadius: BorderRadius.circular(1.sh),
            event: () => showsController
                .moveToPage(AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1)),
        // CustomButton(
        //     buttonType: ButtonType.ICON,
        //     icon: AppSvgs.NOTIFICATION,
        //     onPressed: () => context.push("/notification"))
      ]);
    }

    Widget buildCarouselChild(int index) {
      final voteAverage = results?[index].voteAverage?.toStringAsFixed(1);

      return Stack(alignment: Alignment.topRight, children: [
        CustomImage(
            imageType: ImageType.REMOTE,
            event: () => context.push("/detail/${results?[index].id}"),
            imageUrl:
                ApiConstants.IMAGE_PATH + (results?[index].posterPath ?? ""),
            borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
        if (voteAverage != null && voteAverage != "0.0")
          IgnorePointer(
              child: CustomTag(icon: AppSvgs.STAR, value: voteAverage)
                  .paddingAll(0.05 * carouselHeight))
      ]);
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

    Widget buildMainWidget() {
      final showGenre = getGenre(
          results?[showsState.carouselCurrentIndex].genreIds?[0] ?? -1);

      return blurEffect(
          6.0,
          Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.transparent, AppColors.black3])),
              child: SafeArea(
                  child: Column(children: [
                buildAppBar()
                    .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                const Spacer(),
                buildCarousel(),
                const Spacer(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      capitalFirstWord: true)
                ]).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                SizedBox(height: 0.01 * height),
                CustomText(
                        text: results?[showsState.carouselCurrentIndex]
                                .overview ??
                            "",
                        size: 0.02 * height,
                        align: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis)
                    .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
              ]))));
    }

    if (showsState.shows.isSuccess) {
      return Stack(alignment: Alignment.center, children: [
        CustomImage(
            imageType: ImageType.REMOTE,
            imageUrl: ApiConstants.IMAGE_PATH +
                (results?[showsState.carouselCurrentIndex].posterPath ?? ""),
            height: height),
        buildMainWidget(),
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
