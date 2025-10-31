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
            final top = ref.watch(topShowsProvider);
            final newRelease = ref.watch(newReleaseShowsProvider);
            final upcoming = ref.watch(upcomingShowsProvider);

            return Column(children: [
              buildCollection("Top 20 Movies", top),
              buildCollection("New Release", newRelease),
              buildCollection("Upcoming", upcoming),
            ]);
          })
        ]));
  }

  buildCollection(String collectionName, AsyncValue<List<Result>> shows,
      {bool isStart = false}) {
    return shows.when(
      data: (show) {
        return Column(children: [
          // if (!isStart)
          // Divider(
          //   color: AppColors.black2,
          // ).paddingSymmetric(horizontal: AppConstants.SIDE_PADDING),
          CustomCollection(
              collectionName: collectionName,
              isLoading: false,
              results: show,
              onPressed: () {
                // context.push("/collection");
              }),
        ]);
      },
      loading: () => CustomCollection(collectionName: collectionName),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
