import 'dart:developer';

import 'package:seven/app/app.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<String> _collections = [
    "Now Playing",
    "Popular",
    "Top Rated",
    "Upcoming",
  ];
  final horizontalPadding = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);

    if (showsState.status.isInitial) {
      Future.microtask(() {
        showsController.loadShows();
      });
    }

    if (showsState.status.isLoading || showsState.status.isSuccess) {
      return SingleChildScrollView(
        child: Column(
          children: [
            (showsState.shows.results != null &&
                    showsState.genre.genres != null)
                ? HomeCarousel(
                    results: showsState.shows.results!,
                    genres: showsState.genre.genres!)
                : customShimmer(),
            SizedBox(height: 0.02.sh),
            ...List.generate(
                _collections.length,
                (index) => Column(children: [
                      if (index != 0)
                        const Divider(
                          color: AppColors.black2,
                        ).paddingSymmetric(horizontal: horizontalPadding),
                      CustomCollection(
                          collectionName: _collections[index],
                          isLoading: showsState.status.isLoading,
                          result: showsState.shows.results)
                    ]))
          ],
        ),
      );
    }

    if (showsState.status.isEmpty) {
      return Center(
          child:
              CustomText(text: showsState.status.errorMessage ?? "No Shows"));
    }

    log("Error -> ${showsState.status.errorMessage}");
    return ErrorScreen(onPressed: () => showsController.refresh());
  }
}
