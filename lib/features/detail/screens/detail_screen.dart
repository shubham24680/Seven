import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen(this.id, {super.key});

  final String id;

  static const _sidePadding = AppConstants.SIDE_PADDING;
  static const _gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.5, 1.0],
      colors: [AppColors.transparent, AppColors.black3],
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDetail = ref.watch(showDetailProvider(id));
    final collectionDetail = ref.watch(showCollectionProvider(id));

    return Scaffold(
      body: showDetail.when(
        data: (detail) => _buildContent(context, detail, collectionDetail),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.vividNightfall4),
        ),
        error: (error, stackTrace) => ErrorScreen(
          onPressed: () => ref.read(showDetailProvider(id).notifier).refresh(),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Result detail,
    AsyncValue<Result> collectionDetail,
  ) {
    final width = 1.sw;
    final height = 1.5 * width;

    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildHeroSection(context, detail, width, height),
          SizedBox(height: 0.02.sh),
          if (detail.overview?.isNotEmpty ?? false)
            _buildOverviewSection(context, detail),
          SizedBox(height: 0.02.sh),
          _buildCollection(context, collectionDetail, detail),
          _buildProduction("Production Companies", detail.productionCompanies),
          _buildProduction("Production Countries", detail.productionCountries),
          _buildInformation(detail),
          SizedBox(height: 0.05.sh)
        ]));
  }

  Widget _buildHeroSection(
      BuildContext context, Result detail, double width, double height) {
    final status = detail.status;
    final year = getDateFormat(detail.releaseDate);
    final runtime = getRuntime(detail.runtime);
    final metadataItems = [
      if (status != null) status,
      if (year != null) year,
      if (runtime != null) runtime,
    ].join(" • ");

    return Stack(alignment: Alignment.center, children: [
      CustomImage(
        imageType: ImageType.REMOTE,
        imageUrl: getImageUrl(detail.posterPath),
        height: height,
      ),
      Container(
          height: height,
          width: width,
          decoration: _gradientDecoration,
          child: SafeArea(
              bottom: false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(context),
                    const Spacer(),
                    CustomText(
                      text: detail.title ?? "",
                      family: AppFonts.STAATLICHES,
                      size: 0.05 * height,
                    ).paddingSymmetric(horizontal: _sidePadding),
                    Row(
                      children: [
                        CustomText(text: metadataItems, size: 0.02 * height),
                        const Spacer(),
                        if (detail.voteAverage != null &&
                            detail.voteAverage != "0.0")
                          CustomTag(
                              icon: AppSvgs.STAR, value: detail.voteAverage),
                      ],
                    ).paddingSymmetric(horizontal: _sidePadding),
                    if (detail.genres?.isNotEmpty != null) ...[
                      SizedBox(height: 0.01.sh),
                      _buildGenresList(detail.genres, height)
                    ]
                  ])))
    ]);
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomButton(
      buttonType: ButtonType.ICON,
      icon: AppSvgs.ARROW_LEFT,
      onPressed: () => context.pop(),
    ).paddingFromLTRB(left: _sidePadding, top: 0.5 * _sidePadding);
  }

  Widget _buildGenresList(List<Genre>? genres, double height) {
    if (genres == null) return SizedBox.shrink();
    final validGenres = genres.where((g) => g.name != null).toList();

    return SizedBox(
      height: 0.05 * height,
      child: ListView.builder(
          itemCount: validGenres.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: _sidePadding),
          itemBuilder: (context, index) => CustomTag(
                  tagType: TagType.OUTLINED, value: validGenres[index].name)
              .paddingFromLTRB(right: 0.5 * _sidePadding)),
    );
  }

  Widget _buildOverviewSection(BuildContext context, Result detail) {
    final overview = detail.overview;
    if (overview == null) return SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(
              text: overview,
              size: 0.015.sh,
              color: AppColors.lightSteel1.withAlpha(150),
              maxLines: 3,
              overflow: TextOverflow.ellipsis)
          .paddingSymmetric(horizontal: _sidePadding),
      CustomButton(
              buttonType: ButtonType.TEXT,
              icon: "Read more",
              forgroundColor: AppColors.vividNightfall4,
              onPressed: () => customBottomSheet(
                  context,
                  "Overview",
                  CustomText(
                      text: overview,
                      size: 0.015.sh,
                      weight: FontWeight.w900,
                      align: TextAlign.center),
                  backgroundColor: AppColors.black3.withAlpha(150)))
          .paddingSymmetric(horizontal: _sidePadding),
    ]);
  }

  Widget _buildHeader(String value) {
    return CustomText(text: value, family: AppFonts.STAATLICHES, size: 0.03.sh)
        .paddingFromLTRB(
            left: _sidePadding,
            right: _sidePadding,
            bottom: 0.15 * _sidePadding);
  }

  Widget _buildCollection(BuildContext context,
      AsyncValue<Result> collectionDetail, Result detail) {
    final collectionName =
        detail.belongsToCollection?.name ?? "More in the series";

    return collectionDetail.when(
        data: (show) {
          final filteredParts =
              show.parts?.where((part) => part.id != detail.id).toList();

          return Column(children: [
            CustomCollection(
                collectionName: collectionName,
                isLoading: false,
                results: filteredParts,
                onPressed: () => context.push(
                    "/detailCollection/$collectionName",
                    extra: show.parts)),
            const Divider(color: AppColors.black2)
                .paddingSymmetric(horizontal: _sidePadding)
          ]);
        },
        loading: () => CustomCollection(collectionName: collectionName),
        error: (_, __) => const SizedBox.shrink());
  }

  Widget _buildInformation(Result detail) {
    final language = detail.spokenLanguages
        ?.map((l) => l.englishName)
        .whereType<String>()
        .join(", ");

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildHeader("Information"),
      _buildInformationRow(detail.status,
          getDateFormat(detail.releaseDate, formatType: FormatType.YMMMD)),
      _buildInformationRow("Runtime", getRuntime(detail.runtime)),
      _buildInformationRow(
          "Budget", getCurrencyFormat(detail.budget, detail.originalLanguage)),
      _buildInformationRow("Revenue",
          getCurrencyFormat(detail.revenue, detail.originalLanguage)),
      _buildInformationRow("Orignal Audio", language),
      _buildInformationRow("Homepage", detail.homepage)
    ]);
  }

  Widget _buildInformationRow(String? key, String? value) {
    if (key == null || value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText(text: key, size: 0.015.sh),
      CustomText(
        text: value,
        size: 0.015.sh,
        color: AppColors.lightSteel1.withAlpha(150),
      ),
      SizedBox(height: 0.02.sh)
    ]).paddingSymmetric(horizontal: _sidePadding);
  }

  Widget _buildProduction(String prodName, List<dynamic>? prod) {
    if (prod == null || prod.isEmpty) return const SizedBox.shrink();

    final validItems = prod.where((item) => item.name != null).toList();
    if (validItems.isEmpty) return const SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildHeader(prodName),
      SizedBox(
          height: 0.04.sh,
          child: ListView.builder(
              itemCount: validItems.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: _sidePadding),
              itemBuilder: (context, index) => CustomTag(
                      tagType: TagType.OUTLINED, value: validItems[index].name)
                  .paddingFromLTRB(right: 0.5 * _sidePadding))),
      SizedBox(height: 0.02.sh)
    ]);
  }
}
