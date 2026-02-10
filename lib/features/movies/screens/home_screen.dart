import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollProvider(0)).scrollController;

    buildCollection(String collectionName,
        AsyncNotifierProvider<ShowNotifier, List<Result>> provider) {
      final shows = ref.watch(provider);

      return shows.when(
          data: (show) {
            return Column(children: [
              CustomCollection(
                  collectionName: collectionName,
                  isLoading: false,
                  results: show,
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
      buildCollection("Top Movies", topShowsProvider),
      buildCollection("New Release", newReleaseShowsProvider),
      buildCollection("Upcoming", upcomingShowsProvider),
      buildCollection("All time classic", allTimeClassicShowsProvider),
      buildCollection("Popular in India", popularInIndiaShowsProvider)
    ];

    return ListView.builder(
        itemCount: items.length,
        controller: scrollController,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) => items[index]);
  }
}
