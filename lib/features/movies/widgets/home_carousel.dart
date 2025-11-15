import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileIndex = ref.watch(profileProvider).profilePicIndex;
    final carouselState = ref.watch(showsProvider);
    final carouselController = ref.read(showsProvider.notifier);
    final trending = ref.watch(trendingShowProvider);

    final viewportFraction = 0.7;
    final width = 1.sw;
    final height = 1.5 * width;
    final carouselHeight = viewportFraction * height;

    Widget buildAppBar() {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppImages.AVATARS[profileIndex],
            height: 0.048.sh,
            borderRadius: BorderRadius.circular(1.sh),
            event: () => carouselController
                .moveToPage(AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1)),
        CustomButton(
            buttonType: ButtonType.ICON,
            icon: AppSvgs.SEARCH_OUTLINED,
            onPressed: () => carouselController.moveToPage(1))
      ]).paddingFromLTRB(
          left: AppConstants.SIDE_PADDING,
          top: 0.5 * AppConstants.SIDE_PADDING,
          right: AppConstants.SIDE_PADDING);
    }

    String? getGenre(int genreId) {
      final allGenre = carouselState.genres?.genres;
      final value = allGenre?.firstWhere(
        (gen) => gen.id == genreId,
        orElse: () => Genre(id: -1, name: null),
      );

      return value?.name;
    }

    return trending.when(
        data: (show) {
          final currentShow = show[carouselState.carouselCurrentIndex];

          Widget buildCarousel() {
            return CarouselSlider.builder(
                itemCount: show.length,
                itemBuilder: (context, index, realIndex) => CustomImage(
                    imageType: ImageType.REMOTE,
                    event: () => context.push("/detail/${show[index].id}"),
                    imageUrl: getImageUrl(show[index].posterPath),
                    borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
                options: CarouselOptions(
                    onPageChanged: (index, _) =>
                        carouselController.nextTo(index),
                    initialPage: carouselState.carouselCurrentIndex,
                    height: carouselHeight,
                    viewportFraction: viewportFraction,
                    autoPlay: true,
                    enlargeCenterPage: true));
          }

          Widget buildMainWidget() {
            final decoration = const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.transparent, AppColors.black3]));

            final showGenre = getGenre(currentShow.genreIds?.first);
            final mediaType = currentShow.mediaType;
            final item = <String>[
              if (showGenre != null) showGenre,
              if (mediaType != null) mediaType
            ];
            final overview = currentShow.overview ?? "";
            final child = Container(
                height: height,
                width: width,
                decoration: decoration,
                child: SafeArea(
                    child: Column(children: [
                  buildAppBar(),
                  const Spacer(),
                  buildCarousel(),
                  const Spacer(),
                  CustomText(
                          text: item.join(" • "),
                          size: 0.025 * height,
                          weight: FontWeight.w900)
                      .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                  SizedBox(height: 0.01 * height),
                  CustomText(
                          text: overview,
                          size: 0.02 * height,
                          align: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)
                      .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
                ])));

            return blurEffect(6.0, child);
          }

          return Stack(alignment: Alignment.center, children: [
            CustomImage(
                height: height,
                imageType: ImageType.REMOTE,
                imageUrl: getImageUrl(currentShow.posterPath)),
            buildMainWidget(),
          ]);
        },
        loading: () => Stack(children: [
              customShimmer(height: height),
              SafeArea(child: buildAppBar())
            ]),
        error: (error, stackTrace) => SafeArea(child: buildAppBar()));
  }
}
