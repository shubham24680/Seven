import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselState = ref.watch(showsProvider);
    final carouselController = ref.read(showsProvider.notifier);
    final trending = ref.watch(trendingShowProvider);

    final viewportFraction = 0.7;
    final width = 1.sw;
    final height =
        (DimensionUtil().deviceSize == DeviceSize.SMALL ? 1.5 : 0.57) * width;
    final carouselHeight = viewportFraction * height;

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
          final bgImage = DimensionUtil().deviceSize == DeviceSize.SMALL
              ? currentShow.posterPath
              : currentShow.backdropPath;

          Widget buildCarousel() {
            return CarouselSlider.builder(
                itemCount: show.length,
                itemBuilder: (context, index, realIndex) {
                  final image = DimensionUtil().deviceSize == DeviceSize.SMALL
                      ? show[index].posterPath
                      : show[index].backdropPath;

                  return CustomImage(
                      imageType: ImageType.REMOTE,
                      onClick: () => context.push("/detail/${show[index].id}"),
                      imageUrl: getImageUrl(image),
                      borderRadius:
                          BorderRadius.circular(0.1 * carouselHeight));
                },
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
                child: Column(children: [
                  const HomeAppBar(),
                  Spacer(),
                  buildCarousel(),
                  Spacer(),
                  CustomText(text: item.join(" • "), weight: FontWeight.w900)
                      .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                  SizedBox(height: 0.01 * height),
                  CustomText(
                          text: overview,
                          size: 12.w,
                          align: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)
                      .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
                ]));

            return blurEffect(6.0, child);
          }

          return Stack(alignment: Alignment.topCenter, children: [
            CustomImage(
                height: height,
                imageType: ImageType.REMOTE,
                imageUrl: getImageUrl(bgImage)),
            buildMainWidget(),
          ]);
        },
        loading: () => customShimmer(height: height),
        error: (error, stackTrace) => const SizedBox.shrink());
  }
}
