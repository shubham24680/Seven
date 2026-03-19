import 'package:seven/app/app.dart';

class SportsScreen extends ConsumerWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppColors.vividNightfall4,
                  dividerColor: AppColors.transparent,
                  labelStyle: CustomText(
                    text: "",
                    size: 16.w,
                    weight: FontWeight.w900,
                  ).getTextStyle(),
                  unselectedLabelStyle: CustomText(
                    text: "",
                    size: 12.w,
                    weight: FontWeight.w500,
                  ).getTextStyle(),
                  tabs: [
                    Tab(text: "Live"),
                    Tab(text: "Recent"),
                    Tab(text: "Upcoming"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildMatch(ref, cricketLiveProvider),
                      _buildMatch(ref, cricketLiveProvider),
                      _buildMatch(ref, cricketLiveProvider),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildMatch(WidgetRef ref,
      StateNotifierProvider<CricketNotifier, CricketState> provider) {
    final state = ref.watch(provider);
    final matches = state.matches;
    final loading = state.isLoading;
    final error = state.isError;

    if (loading) {
      return ListView.builder(
          itemCount: 3,
          padding: EdgeInsets.symmetric(vertical: AppConstants.SIDE_PADDING),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0.5 * AppConstants.SIDE_PADDING,
                  horizontal: AppConstants.SIDE_PADDING),
              child: ScoreCard(isLoading: loading),
            );
          });
    }

    if (error) {
      return Center(
        child: CustomText(text: state.errorMessage, size: 12.w),
      );
    }

    return ListView.builder(
      itemCount: matches?.length ?? 0,
      padding: EdgeInsets.symmetric(vertical: AppConstants.SIDE_PADDING),
      itemBuilder: (context, index) {
        final firstTeamLogo = matches?[index].teama?.logoUrl;
        final secondTeamLogo = matches?[index].teamb?.logoUrl;
        final firstTeamColor = state.colors[firstTeamLogo];
        final secondTeamColor = state.colors[secondTeamLogo];

        debugPrint("firstTeamColor: $firstTeamColor");
        debugPrint("secondTeamColor: $secondTeamColor");

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.5 * AppConstants.SIDE_PADDING,
              horizontal: AppConstants.SIDE_PADDING),
          child: ScoreCard(
              isLoading: loading,
              match: matches?[index],
              firstTeamColor: firstTeamColor,
              secondTeamColor: secondTeamColor),
        );
      },
    );
  }
}
