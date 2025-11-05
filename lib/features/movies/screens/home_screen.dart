import 'package:seven/app/app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HomeCarousel(),
          SizedBox(height: 0.02.sh),
          Consumer(builder: (_, ref, __) {
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
                          onPressed: () => context.push(
                              "/collection/$collectionName",
                              extra: provider)),
                      Divider(
                        color: AppColors.black2,
                      ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
                    ]);
                  },
                  loading: () =>
                      CustomCollection(collectionName: collectionName),
                  error: (_, __) => const SizedBox.shrink());
            }

            return Column(children: [
              buildCollection("Top 20 Movies", topShowsProvider),
              buildCollection("New Release", newReleaseShowsProvider),
              buildCollection("Upcoming", upcomingShowsProvider),
            ]);
          })
        ]));
  }
}
