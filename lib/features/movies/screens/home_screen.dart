import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollProvider(0)).scrollController;

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

    final items = [
      const HomeCarousel().paddingFromLTRB(bottom: AppConstants.SIDE_PADDING),
      buildCollection("New Release", newReleaseShowsProvider),
      buildCollection("Popular in India", popularInIndiaShowsProvider),
      buildCollection("Upcoming", upcomingShowsProvider),
      buildCollection("Top Movies", topShowsProvider),
      buildCollection("All time classic", allTimeClassicShowsProvider)
    ];

    return ListView.builder(
        itemCount: items.length,
        controller: scrollController,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) => items[index]);
  }
}
