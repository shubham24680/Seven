import 'dart:developer';

import 'package:seven/app/app.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen(this.id, this.type, {super.key});

  final String id;
  final String type;

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
    final showPath = "$type/$id";
    final showDetail = ref.watch(showDetailProvider(showPath));
    final showCollection = ref.watch(showCollectionProvider(showPath));
    final showCredits = ref.watch(showCreditsProvider(showPath));

    return Scaffold(
        body: showDetail.when(
            data: (detail) =>
                _buildContent(context, detail, showCollection, showCredits),
            loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppColors.vividNightfall4)),
            error: (error, stackTrace) => ErrorScreen(
                onPressed: () => ref
                    .read(showDetailProvider(showPath).notifier)
                    .refresh())));
  }

  Widget _buildContent(BuildContext context, Result detail,
      AsyncValue<Result> showCollection, AsyncValue<Credits> showCredits) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: DimensionUtil().bottomBarHeight),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildHeroSection(context, detail),
          SizedBox(height: 16.w),
          if (detail.overview?.isNotEmpty ?? false)
            _buildOverviewSection(context, detail),
          SizedBox(height: 16.w),
          _buildEpisode(context, detail.nextEpisodeToAir, "Upcoming Episode"),
          _buildEpisode(context, detail.lastEpisodeToAir, "Recent Episode"),
          _buildSeasons(context, detail),
          _buildCollection(context, showCollection, detail),
          _buildCredits(context, showCredits),
          _buildProduction("Production Companies", detail.productionCompanies),
          _buildProduction("Production Countries", detail.productionCountries),
          _buildProduction("Streaming On", detail.networks),
          _buildInformation(detail),
          SizedBox(height: 40.w)
        ]));
  }

  Widget _buildHeroSection(BuildContext context, Result detail) {
    final width = 1.sw;
    final height = width /
        (DimensionUtil().deviceSize == DeviceSize.SMALL
            ? AppConstants.CARD_RATIO_PORTRAIT
            : AppConstants.CARD_RATIO_LANDSCAPE);
    final imageUrl = DimensionUtil().deviceSize == DeviceSize.SMALL
        ? detail.posterPath
        : detail.backdropPath;
    final status = detail.status;
    final year = getDateFormat(detail.releaseDate);
    final runtime = getRuntime(detail.runtime);
    final metadataItems = [
      if (status != null) status,
      if (year != null) year,
      if (runtime != null) runtime,
    ].join(" • ");
    final voteAverage = detail.voteAverage;

    return Stack(children: [
      CustomImage(
          imageType: ImageType.REMOTE,
          imageUrl: getImageUrl(imageUrl),
          height: height,
          width: width),
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
                        if (detail.adult == true)
                          CustomTag(
                              value: "18+",
                              backgroundColor: AppColors.red1.withAlpha(150)),
                        SizedBox(width: 4.w),
                        if (voteAverage != null && voteAverage != "0.0")
                          CustomTag(icon: AppSvgs.STAR, value: voteAverage),
                      ],
                    ).paddingSymmetric(horizontal: _sidePadding),
                    if (detail.genres?.isNotEmpty != null) ...[
                      SizedBox(height: 8.w),
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
              size: 12.w,
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
                      size: 12.w,
                      weight: FontWeight.w900,
                      align: TextAlign.center),
                  backgroundColor: AppColors.black3.withAlpha(150)))
          .paddingSymmetric(horizontal: _sidePadding),
    ]);
  }

  Widget _buildEpisode(
      BuildContext context, EpisodeToAir? episodes, String title) {
    if (episodes == null) return SizedBox.shrink();

    final height = 80.w;
    final voteAverage = episodes.voteAverage?.toStringAsFixed(1);
    final year = getDateFormat(episodes.airDate, formatType: FormatType.YMMMD);
    final runtime = getRuntime(episodes.runtime);
    final season = episodes.seasonNumber;
    final episode = episodes.episodeNumber;
    final seasonEpisode =
        "${(season != null ? "S$season" : "")} ${episode != null ? "E$episode" : ""}";
    final metadataItems = [
      if (seasonEpisode.isNotEmpty) seasonEpisode,
      if (year != null) year,
      if (runtime != null) runtime,
    ].join(" • ");
    final overview = episodes.overview;

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(title),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: _sidePadding,
              children: [
                Stack(alignment: Alignment.topRight, children: [
                  CustomImage(
                      imageType: ImageType.REMOTE,
                      imageUrl: getImageUrl(episodes.stillPath),
                      height: height,
                      width: AppConstants.CARD_RATIO_LANDSCAPE * height,
                      borderRadius: BorderRadius.circular(0.1 * height)),
                  if (voteAverage != null && voteAverage != "0.0")
                    CustomTag(
                            tagSize: TagSize.SMALL,
                            icon: AppSvgs.STAR,
                            value: voteAverage)
                        .paddingAll(0.3 * _sidePadding)
                ]),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: episodes.name ?? "",
                        size: 16.w,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        weight: FontWeight.w900),
                    CustomText(text: metadataItems, size: 10.w)
                  ],
                ))
              ]).paddingSymmetric(horizontal: _sidePadding),
          if (overview != null && overview.isNotEmpty) ...[
            SizedBox(height: 8.w),
            CustomText(
                    text: episodes.overview ?? "",
                    size: 10.w,
                    color: AppColors.lightSteel1.withAlpha(150))
                .paddingSymmetric(horizontal: _sidePadding),
          ],
          SizedBox(height: 24.w),
          const Divider(color: AppColors.black2)
              .paddingSymmetric(horizontal: _sidePadding)
        ]);
  }

  Widget _buildSeasons(BuildContext context, Result detail) {
    final seasons = detail.seasons;
    if (seasons == null || seasons.isEmpty) return SizedBox.shrink();

    int lastEpisode = 1;
    final episodes = seasons.map((season) {
      final currentEpisode = season.episodeCount?.toInt();
      final seasonEpisode = [
        lastEpisode,
        if (currentEpisode != null) lastEpisode + currentEpisode - 1
      ].join(" - ");
      lastEpisode = lastEpisode + (currentEpisode ?? 0);
      return seasonEpisode;
    }).toList();
    final overview = seasons.where((season) {
      final view = season.overview?.trim();
      return view != null && view.isNotEmpty;
    }).toList();
    final imgHeight = 260.w;
    log("Overview - $overview");
    final totalHeight = imgHeight + 25.w + (overview.isEmpty ? 0 : 77.w);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader("Seasons"),
      SizedBox(
          height: totalHeight,
          child: ListView.builder(
              itemCount: seasons.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                  left: _sidePadding, right: 0.5 * _sidePadding),
              itemBuilder: (context, index) {
                final currentSeason = seasons[index];
                final seasonNumber = "Season ${currentSeason.seasonNumber}";
                final title =
                    "Season ${currentSeason.seasonNumber}${(seasonNumber != currentSeason.name) ? "\n${currentSeason.name}" : ""}";
                final desc = seasons[index].overview;
                final year = getDateFormat(currentSeason.airDate,
                    formatType: FormatType.YMMMD);

                return SizedBox(
                    width: AppConstants.CARD_RATIO_PORTRAIT * imgHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: imgHeight,
                            width: AppConstants.CARD_RATIO_PORTRAIT * imgHeight,
                            child: CustomCard(
                                orientation: CardOrientation.POTRAIT,
                                title: title,
                                imageUrl: currentSeason.posterPath,
                                voteAverage: currentSeason.voteAverage
                                    ?.toStringAsFixed(1),
                                episodes: episodes[index])),
                        if (desc != null && desc.isNotEmpty) ...[
                          SizedBox(height: 8.w),
                          CustomText(
                                  text: desc,
                                  size: 10.w,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.lightSteel1.withAlpha(150))
                              .paddingSymmetric(horizontal: _sidePadding),
                        ],
                        if (year != null) ...[
                          SizedBox(height: 8.w),
                          CustomText(text: year, size: 10.w)
                              .paddingSymmetric(horizontal: _sidePadding),
                        ]
                      ],
                    )).paddingFromLTRB(right: 0.5 * _sidePadding);
              })),
      SizedBox(height: 24.w),
      const Divider(color: AppColors.black2)
          .paddingSymmetric(horizontal: _sidePadding)
    ]);
  }

  Widget _buildCollection(BuildContext context,
      AsyncValue<Result> collectionDetail, Result detail) {
    final collectionName =
        detail.belongsToCollection?.title ?? "More in the series";

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

  Widget _buildCredits(BuildContext context, AsyncValue<Credits> showCredits) {
    return showCredits.when(
        data: (credits) {
          final credit = [...credits.cast ?? [], ...credits.crew ?? []];
          if (credit.isEmpty) return SizedBox.shrink();

          return Column(children: [
            CustomCollection(
                    collectionName: "Cast & Crew",
                    isLoading: false,
                    onPressed: () =>
                        context.push("/castCollection/$id", extra: type))
                .buildText(),
            SizedBox(
                height: 160.w,
                child: ListView.builder(
                    itemCount: credit.length,
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.only(left: _sidePadding),
                    itemBuilder: (context, index) {
                      final castOrCrew = credit[index];

                      return SizedBox(
                          width: 100.w, child: buildCastAndCrew(castOrCrew));
                    })),
            SizedBox(height: 16.w),
            const Divider(color: AppColors.black2)
                .paddingSymmetric(horizontal: _sidePadding)
          ]);
        },
        loading: () => Column(children: [
              CustomCollection(collectionName: "Cast & Crew").buildText(),
              SizedBox(
                height: 120.w,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.only(left: _sidePadding),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 100.w,
                        child: buildCastAndCrewLoading()
                            .paddingFromLTRB(top: _sidePadding),
                      );
                    }),
              ),
              SizedBox(height: 16.w),
              const Divider(color: AppColors.black2)
                  .paddingSymmetric(horizontal: _sidePadding)
            ]),
        error: (_, __) => const SizedBox.shrink());
  }

  Widget _buildInformation(Result detail) {
    final language = detail.spokenLanguages
        ?.map((l) => l.englishName)
        .whereType<String>()
        .join(", ");
    final homepage = detail.homepage;
    final date =
        getDateFormat(detail.releaseDate, formatType: FormatType.YMMMD);
    final runtime = getRuntime(detail.runtime);
    final budget = getCurrencyFormat(detail.budget, detail.originalLanguage);
    final revenue = getCurrencyFormat(detail.revenue, detail.originalLanguage);
    final childAspectRatio = DimensionUtil().isPortrait ? 3.5 : 0.285;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader("Information"),
      GridView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: childAspectRatio),
          children: [
            if (detail.status != null && date != null)
              _buildInformationRow(detail.status, date),
            if (runtime != null && runtime.isNotEmpty)
              _buildInformationRow("Runtime", runtime),
            if (budget != null && budget.isNotEmpty)
              _buildInformationRow("Budget", budget),
            if (revenue != null && revenue.isNotEmpty)
              _buildInformationRow("Revenue", revenue)
          ]),
      _buildInformationRow("Orignal Audio", language),
      if (homepage != null && homepage.isNotEmpty)
        Row(children: [
          CustomText(text: "Homepage", size: 0.015.sh),
          SizedBox(width: 0.01.sw),
          CustomImage(
              imageType: ImageType.SVG_LOCAL,
              imageUrl: AppSvgs.LINK,
              color: AppColors.lightSteel1.withAlpha(70),
              onClick: () => customUrlLauncher(homepage))
        ]).paddingSymmetric(horizontal: _sidePadding),
    ]);
  }

  Widget _buildInformationRow(String? key, String? value) {
    if (key == null || value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: key, size: 0.015.sh),
          CustomText(
              text: value,
              size: 0.015.sh,
              color: AppColors.lightSteel1.withAlpha(150)),
          SizedBox(height: 0.02.sh)
        ]).paddingSymmetric(horizontal: _sidePadding);
  }

  Widget _buildProduction(String prodName, List<dynamic>? prod) {
    if (prod == null || prod.isEmpty) return const SizedBox.shrink();

    final validItems = prod.where((item) => item.name != null).toList();
    if (validItems.isEmpty) return const SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader(prodName),
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
