import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDetail = ref.watch(showDetailProvider(id));
    final showDetailController = ref.read(showDetailProvider(id).notifier);
    final collectionDetail = ref.watch(showCollectionProvider(id));
    final width = 1.sw;
    final height = 1.5 * width;

    Widget buildAppBar() {
      return CustomButton(
              buttonType: ButtonType.ICON,
              icon: AppSvgs.ARROW_LEFT,
              onPressed: () => context.pop())
          .paddingFromLTRB(
              left: AppConstants.SIDE_PADDING,
              top: 0.5 * AppConstants.SIDE_PADDING);
    }

    return Scaffold(
        body: showDetail.when(
            data: (detail) {
              log('detail: ${detail.id}, belongTo: ${detail.belongsToCollection?.id} , name: DetailScreen');
              final overview = detail.overview;
              final collectionName =
                  detail.belongsToCollection?.name ?? "More in the series";

              Widget buildMainWidget() {
                final decoration = const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                        colors: [AppColors.transparent, AppColors.black3]));
                final status = detail.status;
                final releaseDate = detail.releaseDate;
                final year = (releaseDate != null)
                    ? DateFormat.y().format(releaseDate)
                    : null;
                final showRuntime = detail.runtime;
                final runtime = (showRuntime != null && showRuntime > 0)
                    ? "$showRuntime min"
                    : null;
                final item = <String>[
                  if (status != null) status,
                  if (year != null) year,
                  if (runtime != null) runtime
                ];
                final voteAverage = detail.voteAverage?.toStringAsFixed(1);
                final genres = detail.genres;

                return Container(
                    height: height,
                    width: width,
                    decoration: decoration,
                    child: SafeArea(
                        bottom: false,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildAppBar(),
                              const Spacer(),
                              CustomText(
                                      text: detail.title ?? "",
                                      family: AppFonts.STAATLICHES,
                                      size: 0.05 * height)
                                  .paddingSymmetric(
                                      horizontal: AppConstants.SIDE_PADDING),
                              Row(children: [
                                CustomText(
                                    text: item.join(" • "),
                                    size: 0.02 * height),
                                Spacer(),
                                if (voteAverage != null && voteAverage != "0.0")
                                  CustomTag(
                                      icon: AppSvgs.STAR, value: voteAverage),
                              ]).paddingSymmetric(
                                  horizontal: AppConstants.SIDE_PADDING),
                              if (genres != null && genres.isNotEmpty) ...[
                                SizedBox(height: 0.01.sh),
                                SizedBox(
                                    height: 0.05 * height,
                                    child: ListView.builder(
                                        itemCount: genres.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: AppConstants.SIDE_PADDING),
                                        itemBuilder: (context, index) {
                                          final name = genres[index].name;
                                          if (name == null)
                                            return SizedBox.shrink();

                                          return CustomTag(
                                                  tagType: TagType.OUTLINED,
                                                  value: name)
                                              .paddingFromLTRB(
                                                  right: 0.5 *
                                                      AppConstants
                                                          .SIDE_PADDING);
                                        }))
                              ]
                            ])));
              }

              return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(alignment: Alignment.center, children: [
                          CustomImage(
                              imageType: ImageType.REMOTE,
                              imageUrl: getImageUrl(detail.posterPath),
                              height: height),
                          buildMainWidget(),
                        ]),
                        SizedBox(height: 0.02.sh),
                        if (overview != null && overview.isNotEmpty) ...[
                          CustomText(
                                  text: detail.overview ?? "",
                                  size: 0.015.sh,
                                  color: AppColors.lightSteel1.withAlpha(150),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis)
                              .paddingSymmetric(
                                  horizontal: AppConstants.SIDE_PADDING),
                          CustomButton(
                            buttonType: ButtonType.TEXT,
                            icon: "Read more",
                            forgroundColor: AppColors.vividNightfall4,
                            onPressed: () {},
                          ).paddingSymmetric(
                              horizontal: AppConstants.SIDE_PADDING)
                        ],
                        SizedBox(height: 0.02.sh),
                        collectionDetail.when(
                            data: (show) {
                              log('show: ${show.id}', name: 'DetailScreen');
                              return Column(children: [
                                CustomCollection(
                                    collectionName: collectionName,
                                    isLoading: false,
                                    results: show.parts
                                        ?.where((x) => x.id != detail.id)
                                        .toList(),
                                    onPressed: () {}),
                                const Divider(color: AppColors.black2)
                                    .paddingSymmetric(
                                        horizontal: AppConstants.SIDE_PADDING)
                              ]);
                            },
                            loading: () => CustomCollection(
                                collectionName: collectionName),
                            error: (error, stackTrace) =>
                                const SizedBox.shrink()),
                        buildProduction(
                            "Production Companies", detail.productionCompanies),
                        buildProduction(
                            "Production Countries", detail.productionCountries)
                      ]));
            },
            loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppColors.vividNightfall4)),
            error: (error, stackTrace) {
              return ErrorScreen(
                  onPressed: () => showDetailController.refresh());
            }));
  }

  Widget buildProduction(String prodName, List<dynamic>? prod) {
    if (prod == null || prod.isEmpty) return SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(text: prodName, family: AppFonts.STAATLICHES, size: 0.03.sh)
          .paddingFromLTRB(
              left: AppConstants.SIDE_PADDING,
              right: AppConstants.SIDE_PADDING,
              bottom: 0.2 * AppConstants.SIDE_PADDING),
      SizedBox(
          height: 0.04.sh,
          child: ListView.builder(
              itemCount: prod.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: AppConstants.SIDE_PADDING),
              itemBuilder: (context, index) {
                final name = prod[index].name;
                if (name == null) return SizedBox.shrink();

                return CustomTag(tagType: TagType.OUTLINED, value: name)
                    .paddingFromLTRB(right: 0.5 * AppConstants.SIDE_PADDING);
              })),
      SizedBox(height: 0.02.sh),
    ]);
  }
}
