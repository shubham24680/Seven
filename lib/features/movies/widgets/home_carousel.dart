import 'dart:math';

import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel(
      {super.key,
      required this.results,
      required this.genres,
      this.viewportFraction = 0.7});

  final List<Result> results;
  final List<Genre> genres;
  final double viewportFraction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(carouselCurrentIndex);
    final width = 1.sw;
    final height = 1.5 * width;
    final carouselHeight = viewportFraction * height;

    Widget buildAppBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            imageType: ImageType.LOCAL,
            imageUrl: AppImages.AVATAR_1,
            height: 0.048.sh,
            borderRadius: BorderRadius.circular(100),
            event: () => ref
                .read(showsProvider.notifier)
                .moveToPage(AppAssets.BOTTOM_NAVIGATION_ICONS.length - 1),
          ),
          CustomButton(
            buttonType: ButtonType.ICON,
            icon: AppIcons.NOTIFICATION,
            onPressed: () => context.push("/notification"),
          ),
        ],
      );
    }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        min(results[currentIndex].genreIds!.length, 4),
                        (index) => Wrap(
                              children: [
                                if (index != 0) const CustomText(text: " • "),
                                CustomText(
                                  text: _getGenre(
                                      results[currentIndex].genreIds?[index] ??
                                          -1),
                                  size: 0.025 * height,
                                  weight: FontWeight.w900,
                                )
                              ],
                            )),
                  ),
                  SizedBox(height: 0.01 * height),
                  CustomText(
                    text: results[currentIndex].overview ?? "",
                    size: 0.02 * height,
                    align: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
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
                imageUrl:
                    ApiConstants.IMAGE_PATH + (results[index].posterPath ?? ""),
                borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
          ),
          customTag(AppSvgs.STAR,
                  (results[index].voteAverage ?? 0.0).toStringAsFixed(1))
              .paddingAll(0.02.sh)
        ],
      );
    }

    Widget buildCarousel() {
      return CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) => buildCarouselChild(index),
          itemCount: results.length,
          options: CarouselOptions(
              onPageChanged: (index, _) =>
                  ref.read(carouselCurrentIndex.notifier).state = index,
              autoPlay: true,
              height: carouselHeight,
              viewportFraction: viewportFraction,
              enlargeCenterPage: true));
    }

    return SizedBox(
        height: height,
        width: width,
        child: Stack(alignment: Alignment.center, children: [
          CustomImage(
              imageType: ImageType.REMOTE,
              imageUrl: ApiConstants.IMAGE_PATH +
                  (results[currentIndex].posterPath ?? "")),
          buildMainWidget(),
          buildCarousel().onTap(event: () {
            debugPrint("onTap");
            context.push("/detail");
          }),
        ]));
  }

  String _getGenre(int genreId) {
    final value = genres.firstWhere(
      (gen) => gen.id == genreId,
      orElse: () => Genre(id: -1, name: ""),
    );

    return value.name!;
  }
}
