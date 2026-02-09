import 'package:seven/app/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(showsProvider).scrollController;

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

    return SingleChildScrollView(
        controller: scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HomeCarousel(),
          SizedBox(height: 20.w),
          Column(children: [
            buildCollection("Top Movies", topShowsProvider),
            buildCollection("New Release", newReleaseShowsProvider),
            buildCollection("Upcoming", upcomingShowsProvider),
            buildCollection("All time classic", allTimeClassicShowsProvider),
            buildCollection("Popular in India", popularInIndiaShowsProvider),
          ])
        ]));
  }
}
