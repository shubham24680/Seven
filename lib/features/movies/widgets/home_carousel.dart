import 'package:seven/app/app.dart';

class HomeCarousel extends ConsumerWidget {
  const HomeCarousel({super.key, required this.results, required this.genres});

  final List<Result> results;
  final List<Genre> genres;
  final double viewportFraction = 0.7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(carouselCurrentIndex);
    final width = 1.sw;
    final height = 1.5 * width;
    final carouselHeight = 0.7 * height;

    Widget buildChild(int index) {
      return GestureDetector(
        onTap: () {},
        child: CustomImage(
            imageType: ImageType.REMOTE,
            imageUrl:
                ApiConstants.IMAGE_PATH + (results[index].posterPath ?? ""),
            placeholder: customShimmer(),
            borderRadius: BorderRadius.circular(0.1 * carouselHeight)),
      );
    }

    return SizedBox(
        height: height,
        width: width,
        child: Stack(alignment: Alignment.center, children: [
          CustomImage(
            imageType: ImageType.REMOTE,
            imageUrl: ApiConstants.IMAGE_PATH +
                (results[currentIndex].posterPath ?? ""),
            placeholder: customShimmer(),
            height: height,
          ),
          blurEffect(
              6.0,
              Container(
                  height: height,
                  width: width,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * width),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.transparent, AppColors.black3])),
                  child: SafeArea(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            buttonType: ButtonType.ICON,
                            icon: AppIcons.PROFILE,
                          ),
                          CustomButton(
                            buttonType: ButtonType.ICON,
                            icon: AppIcons.ADD_TO_FAVOURITE,
                          )
                        ],
                      ).paddingFromLTRB(top: 0.02 * height),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            results[currentIndex].genreIds!.length,
                            (index) => Wrap(
                                  children: [
                                    if (index != 0)
                                      const CustomText(text: " • "),
                                    CustomText(
                                      text: _getGenre(results[currentIndex]
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
                        text: results[currentIndex].overview ?? "",
                        size: 0.02 * height,
                        align: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )))),
          CarouselSlider.builder(
              itemBuilder: (context, index, realIndex) => buildChild(index),
              options: CarouselOptions(
                  onPageChanged: (index, _) =>
                      ref.read(carouselCurrentIndex.notifier).state = index,
                  height: carouselHeight,
                  viewportFraction: viewportFraction,
                  enlargeCenterPage: true),
              itemCount: results.length)
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
