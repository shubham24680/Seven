import 'dart:developer';

import 'package:seven/app/app.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<String> _collections = [
    "Top 20 Movies",
    "Action",
    "Adventures",
    "TV Shows",
    "Horror"
  ];
  final horizontalPadding = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showsState = ref.watch(showsProvider);
    final showsController = ref.read(showsProvider.notifier);
    final width = 1.sw;
    final height = 1.5 * width;

    if (showsState.status.isInitial) {
      Future.microtask(() {
        showsController.loadShows();
      });
    }

    if (showsState.status.isLoading || showsState.status.isSuccess) {
      Widget buildHeader() {
        return SizedBox(
            width: width,
            height: height,
            child: (showsState.status.isLoading)
                ? customShimmer()
                : PageView.builder(
                    itemCount: showsState.shows.results!.length,
                    itemBuilder: (context, index) => Stack(children: [
                      CustomImage(
                        imageType: ImageType.REMOTE,
                        imageUrl: ApiConstants.IMAGE_PATH +
                            (showsState.shows.results?[index].posterPath ?? ""),
                        placeholder: customShimmer(),
                        height: height,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: CustomButton(
                            buttonType: ButtonType.ICON,
                            icon: AppIcons.ADD_TO_FAVOURITE,
                            backgroundColor: AppColors.black5.withAlpha(70),
                            borderRadius: 50.0,
                          ).paddingFromLTRB(top: 40, right: 20))
                    ]),
                  ));
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(),
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
