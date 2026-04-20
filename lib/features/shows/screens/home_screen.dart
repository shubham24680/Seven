import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final _collections = AppConstants.HOME_COLLECTIONS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollProvider(0)).scrollController;
    final providerStates = _collections.map((e) {
      final prov = e.provider;
      if (prov == null) return null;
      return ref.watch(prov);
    }).toList();
    final providerCount = providerStates.whereType<AsyncValue<List<Result>>>().length;
    final errorCount = providerStates
        .where((s) => s?.hasError == true && s?.isLoading == false)
        .length;

    if (providerCount > 0 && errorCount == providerCount) {
      return ErrorScreen(
        goBack: false,
        onPressed: () {
          for (var element in _collections) {
            final prov = element.provider;
            if (prov != null) {
              ref.invalidate(prov);
            }
          }
        },
      );
    }

    Widget buildCollection(String collectionName,
        AsyncNotifierProvider<ShowNotifier, List<Result>> provider,
        {String screenPath = "movie"}) {
      final shows = ref.watch(provider);

      return shows.when(
          data: (show) {
            return Column(children: [
              CustomCollection(
                  collectionName: collectionName,
                  isLoading: false,
                  results: show,
                  orientation: CardOrientation.POTRAIT,
                  type: screenPath,
                  onPressed: () => context.push("/collection/$collectionName",
                      extra: provider)),
            ]);
          },
          loading: () => CustomCollection(
              collectionName: collectionName,
              orientation: CardOrientation.POTRAIT),
          error: (_, __) => const SizedBox.shrink());
    }

    Widget buildPoster(int id, String imageUrl, {String mediaType = "movie"}) {
      final width = 1.sw;
      final height = width / AppConstants.CARD_RATIO_LANDSCAPE;
      final borderRadius = 0.06 * height;

      return Column(
        children: [
          SizedBox(height: 8.w),
          CustomImage(
              imageType: ImageType.LOCAL,
              imageUrl: imageUrl,
              height: height,
              width: width,
              onClick: () => context.push("/detailCollection/$id"),
              borderRadius: BorderRadius.circular(borderRadius)),
          SizedBox(height: 24.w),
        ],
      ).padding(horizontal: AppConstants.SIDE_PADDING);
    }

    return ListView.separated(
        itemCount: _collections.length,
        controller: scrollController,
        padding: EdgeInsets.only(bottom: DimensionUtil().bottomBarHeight),
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = _collections[index];
          final prov = item.provider;
          final mediaType = item.mediaType ?? "movie";
          final id = item.id;

          return switch (item.type) {
            HomeWidgetType.CAROUSEL => const HomeCarousel()
                .paddingFromLTRB(bottom: AppConstants.SIDE_PADDING),
            HomeWidgetType.COLLECTION => (prov != null)
                ? buildCollection(item.title, prov, screenPath: mediaType)
                : const SizedBox.shrink(),
            HomeWidgetType.POSTER => (id != null)
                ? buildPoster(id, item.title, mediaType: mediaType)
                : const SizedBox.shrink(),
          };
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0 ||
              _collections[index].type == HomeWidgetType.POSTER ||
              (index < _collections.length &&
                  _collections[index + 1].type == HomeWidgetType.POSTER)) {
            return const SizedBox.shrink();
          }

          return Divider(color: AppColors.black2)
              .padding(horizontal: AppConstants.SIDE_PADDING);
        });
  }
}
