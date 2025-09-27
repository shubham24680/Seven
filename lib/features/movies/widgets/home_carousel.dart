import 'dart:math';

import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key, this.viewportFraction = 0.7});
  final double viewportFraction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);
    final width = 1.sw;
    final height = 1.5 * width;
    final carouselHeight = viewportFraction * height;

    if (showsState.shows.isInitial) {
      Future.microtask(() {
        showsController.loadAllData();
      });
    }

    String getGenre(int genreId) {
      final value = showsState.genre.genres?.firstWhere(
        (gen) => gen.id == genreId,
        orElse: () => Genre(id: -1, name: ""),
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
            event: () => ref
                .read(showsProvider.notifier)
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

    if (showsState.shows.isSuccess) {
      Widget buildMainWidget() {
        return blurEffect(
            6.0,
            Container(
                padding: EdgeInsets.fromLTRB(
                    0.05 * width, 0.02 * height, 0.05 * width, 0.0),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.transparent, AppColors.black3])),
                child: SafeArea(
                    child: Column(
                  children: [
                    buildAppBar(),
                    const Spacer(),
                    if (showsState.genre.genres != null &&
                        showsState.genre.genres!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            min(
                                showsState
                                        .shows
                                        .results?[
                                            showsState.carouselCurrentIndex]
                                        .genreIds
                                        ?.length ??
                                    0,
                                4),
                            (index) => Wrap(
                                  children: [
                                    if (index != 0)
                                      const CustomText(text: " • "),
                                    CustomText(
                                      text: getGenre(showsState
                                              .shows
                                              .results?[showsState
                                                  .carouselCurrentIndex]
                                              .genreIds?[index] ??
                                          -1),
                                      size: 0.025 * height,
                                      weight: FontWeight.w900,
                                    )
                                  ],
                                )),
                      ),
                    SizedBox(height: 0.01 * height),
                    CustomText(
                        text: showsState
                                .shows
                                .results?[showsState.carouselCurrentIndex]
                                .overview ??
                            "",
                        size: 0.02 * height,
                        align: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis)
                  ],
                ))));
      }

      Widget buildCarouselChild(int index) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            IgnorePointer(
              child: CustomImage(
                  imageType: ImageType.REMOTE,
                  imageUrl: ApiConstants.IMAGE_PATH +
                      (showsState.shows.results?[index].posterPath ?? ""),
                  borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
            ),
            customTag(
                    AppSvgs.STAR,
                    (showsState.shows.results?[index].voteAverage ?? -1.0)
                        .toStringAsFixed(1))
                .paddingAll(0.02.sh)
          ],
        );
      }

      Widget buildCarousel() {
        return CarouselSlider.builder(
            itemBuilder: (context, index, realIndex) =>
                buildCarouselChild(index),
            itemCount: showsState.shows.results?.length ?? 0,
            options: CarouselOptions(
                onPageChanged: (index, _) => showsController.nextTo(index),
                initialPage: showsState.carouselCurrentIndex,
                height: carouselHeight,
                viewportFraction: viewportFraction,
                autoPlay: true,
                enlargeCenterPage: true));
      }

      return SizedBox(
          height: height,
          width: width,
          child: Stack(alignment: Alignment.center, children: [
            CustomImage(
                imageType: ImageType.REMOTE,
                imageUrl: ApiConstants.IMAGE_PATH +
                    (showsState.shows.results?[showsState.carouselCurrentIndex]
                            .posterPath ??
                        "")),
            buildMainWidget(),
            buildCarousel().onTap(event: () {
              debugPrint("onTap");
              context.push("/detail");
            }),
          ]));
    }

    debugPrint(
        "${showsState.shows.apiStatus} -> ${showsState.shows.errorMessage}");
    return SafeArea(child: buildAppBar().paddingAll(AppConstants.SIDE_PADDING));
  }
}
