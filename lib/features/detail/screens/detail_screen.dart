import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDetailState = ref.watch(showDetailProvider(id));
    final showDetailController = ref.read(showDetailProvider(id).notifier);
    final show = showDetailState.showDetail;
    final collectionId =
        showDetailState.showDetail.belongsToCollection?.id?.toString();
    final collection = showDetailState.collectionDetail;
    final width = 1.sw;
    final height = 1.5 * width;

    log("Show id -> $id, collection id -> ${show.belongsToCollection?.id}");
    if (collection.isInitial && collectionId != null) {
      Future.microtask(() {
        showDetailController.loadCollectionDetail(collectionId);
      });
    }

    Widget buildAppBar() {
      return CustomButton(
          buttonType: ButtonType.ICON,
          icon: AppSvgs.ARROW_LEFT,
          onPressed: () => context.pop());
    }

    Widget buildMainWidget() {
      final year = (show.releaseDate != null)
          ? DateFormat.y().format(show.releaseDate!)
          : null;
      final showRuntime = show.runtime;
      final runtime = (showRuntime != null && showRuntime > 0)
          ? "${show.runtime} min"
          : null;
      final voteAverage = show.voteAverage?.toStringAsFixed(1);
      final item = <String>[
        if (show.status != null) show.status!,
        if (year != null) year,
        if (runtime != null) runtime,
      ];

      return Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                  colors: [AppColors.transparent, AppColors.black3])),
          child: SafeArea(
              bottom: false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppBar().paddingSymmetric(
                        horizontal: AppConstants.SIDE_PADDING),
                    const Spacer(),
                    CustomText(
                            text: show.title ?? "",
                            family: AppFonts.STAATLICHES,
                            size: 0.05 * height)
                        .paddingSymmetric(
                            horizontal: AppConstants.SIDE_PADDING),
                    Row(children: [
                      if (item.isNotEmpty)
                        CustomText(text: item.join(" • "), size: 0.02 * height),
                      Spacer(),
                      if (voteAverage != null && voteAverage != "0.0")
                        CustomTag(icon: AppSvgs.STAR, value: voteAverage),
                    ]).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                    SizedBox(height: 0.01.sh),
                    SizedBox(
                        height: 0.05 * height,
                        child: ListView.builder(
                            itemCount: show.genres?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(
                                left: AppConstants.SIDE_PADDING),
                            itemBuilder: (context, index) {
                              final name = show.genres?[index].name;
                              if (name == null) return SizedBox.shrink();

                              return CustomTag(
                                      tagType: TagType.OUTLINED, value: name)
                                  .paddingFromLTRB(
                                      right: 0.5 * AppConstants.SIDE_PADDING);
                            }))
                  ])));
    }

    Widget buildBody() {
      if (show.isLoading) {
        return Center(
            child: CircularProgressIndicator(color: AppColors.vividNightfall4));
      }

      if (show.isSuccess) {
        final overview = show.overview;

        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(alignment: Alignment.center, children: [
                CustomImage(
                    imageType: ImageType.REMOTE,
                    imageUrl: ApiConstants.IMAGE_PATH + (show.posterPath ?? ""),
                    height: height),
                buildMainWidget(),
              ]),
              SizedBox(height: 0.02.sh),
              if (overview != null && overview.isNotEmpty) ...[
                CustomText(
                        text: show.overview ?? "",
                        size: 0.015.sh,
                        color: AppColors.lightSteel1.withAlpha(150),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis)
                    .paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                CustomButton(
                  buttonType: ButtonType.TEXT,
                  icon: "Read more",
                  forgroundColor: AppColors.vividNightfall4,
                  onPressed: () => collectionId != null
                      ? showDetailController.loadCollectionDetail(collectionId)
                      : null,
                ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING)
              ],
              SizedBox(height: 0.02.sh),
              if (collection.isSuccess || collection.isLoading) ...[
                CustomCollection(
                  collectionName:
                      show.belongsToCollection?.name ?? "More in the series",
                  isLoading: collection.isLoading,
                  results:
                      collection.parts?.where((x) => x.id != show.id).toList(),
                  onPressed: () {},
                ),
                const Divider(
                  color: AppColors.black2,
                ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
              ],
              buildProduction("Production Companies", show.productionCompanies),
              buildProduction("Production Countries", show.productionCountries),
            ],
          ),
        );
      }

      return ErrorScreen(onPressed: () => showDetailController.refreshData());
    }

    return Scaffold(body: buildBody());
  }

  Widget buildProduction(String prodName, List<dynamic>? prod) {
    if (prod?.firstOrNull == null) return SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(text: prodName, family: AppFonts.STAATLICHES, size: 0.03.sh)
          .paddingFromLTRB(
              left: AppConstants.SIDE_PADDING,
              right: AppConstants.SIDE_PADDING,
              bottom: 0.2 * AppConstants.SIDE_PADDING),
      SizedBox(
          height: 0.04.sh,
          child: ListView.builder(
              itemCount: prod?.length ?? 0,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: AppConstants.SIDE_PADDING),
              itemBuilder: (context, index) {
                final value = prod?[index];
                final name = value?.name;
                if (name == null) return SizedBox.shrink();

                return CustomTag(tagType: TagType.OUTLINED, value: name)
                    .paddingFromLTRB(right: 0.5 * AppConstants.SIDE_PADDING);
              })),
      SizedBox(height: 0.02.sh)
    ]);
  }
}
