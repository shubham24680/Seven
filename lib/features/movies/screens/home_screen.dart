import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final _collections = AppConstants.HOME_COLLECTIONS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollProvider(0)).scrollController;
    final states = _collections.map((e) => ref.watch(e.provider)).toList();
    final errorCount = states.where((s) => s.hasError && !s.isLoading).length;

    if (errorCount == _collections.length) {
      return ErrorScreen(
        goBack: false,
        onPressed: () {
          for (var element in _collections) {
            ref.invalidate(element.provider);
          }
        },
      );
    }

    Widget buildCollection(String collectionName,
        AsyncNotifierProvider<ShowNotifier, List<Result>> provider) {
      final shows = ref.watch(provider);

      return shows.when(
          data: (show) {
            return Column(children: [
              CustomCollection(
                  collectionName: collectionName,
                  isLoading: false,
                  results: show,
                  orientation: CardOrientation.POTRAIT,
                  onPressed: () => context.push("/collection/$collectionName",
                      extra: provider)),
              Divider(
                color: AppColors.black2,
              ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
            ]);
          },
          loading: () => CustomCollection(collectionName: collectionName),
          error: (_, __) => const SizedBox.shrink());
    }

    return ListView.builder(
        itemCount: _collections.length,
        controller: scrollController,
        padding: EdgeInsets.only(bottom: DimensionUtil().bottomBarHeight),
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = _collections[index];

          return switch (item.type) {
            HomeWidgetType.CAROUSEL => const HomeCarousel()
                .paddingFromLTRB(bottom: AppConstants.SIDE_PADDING),
            HomeWidgetType.COLLECTION =>
              buildCollection(item.title, item.provider),
          };
        });
  }
}
