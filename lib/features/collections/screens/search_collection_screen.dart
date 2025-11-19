import 'package:seven/app/app.dart';

class SearchCollectionScreen extends ConsumerWidget {
  const SearchCollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider(searchWithTitle));
    final searchController = ref.read(searchProvider(searchWithTitle).notifier);
    final search = ref.watch(searchWithTitle);
    final controller = ref.read(searchWithTitle.notifier);

    final firstChild = Row(children: [
      Expanded(
          flex: 4,
          child: CustomTextField(
              controller: searchState.searchController,
              onChanged: (value) =>
                  searchController.readyToSearch((value?.length ?? 0) > 1),
              filled: true,
              autofocus: true,
              hintText: "Search movies",
              perfixIcon: CustomImage(
                  imageType: ImageType.SVG_LOCAL,
                  imageUrl: AppSvgs.ARROW_LEFT,
                  color: AppColors.lightSteel1.withAlpha(40),
                  onClick: () => context.pop()))),
      if (searchState.searchValueExist) ...[
        SizedBox(width: 0.02.sw),
        Expanded(
            child: CustomButton(
                buttonType: ButtonType.ELEVATED,
                onPressed: () =>
                    controller.search(searchState.searchController.text),
                height: 0.07.sh,
                backgroundColor: AppColors.vividNightfall4,
                child: CustomText(text: "Go", weight: FontWeight.w900)))
      ],
    ]).paddingSymmetric(vertical: AppConstants.SIDE_PADDING);

    // final borderRadius =
    //     BorderRadius.vertical(bottom: Radius.circular(0.015.sh));
    // final appbar = SliverAppBar(
    //     automaticallyImplyLeading: false,
    //     title: firstChild,
    //     floating: true,
    //     snap: true,
    //     toolbarHeight: 0.095.sh,
    //     shape: RoundedRectangleBorder(borderRadius: borderRadius),
    //     flexibleSpace: blurEffect(
    //         20.0, Container(color: AppColors.black3.withAlpha(200)),
    //         borderRadius: borderRadius));

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0.1.sh,
            title: firstChild,
            flexibleSpace: blurEffect(
                20.0, Container(color: AppColors.black3.withAlpha(200)))),
        body: search
            .when(
                data: (data) => CustomCollection(
                    scrollController: searchState.scrollController,
                    scrollDirection: Axis.vertical,
                    orientation: CardOrientation.POTRAIT,
                    isSafeHeight: true,
                    isLoading: searchState.isLoading,
                    crossAxisCount: 2,
                    loadingItemCount: 2,
                    results: data),
                loading: () => CustomCollection(
                    scrollDirection: Axis.vertical,
                    orientation: CardOrientation.POTRAIT,
                    isSafeHeight: true,
                    crossAxisCount: 2,
                    loadingItemCount: 2),
                error: (error, stackTrace) =>
                    Center(child: CustomText(text: "No Result")))
            .onTap(event: () => FocusScope.of(context).unfocus()),
        floatingActionButton: AnimatedCrossFade(
            firstChild: FloatingActionButton.small(
                onPressed: () => searchController.animateToTop(),
                backgroundColor: AppColors.vividNightfall4,
                elevation: 3,
                focusColor: Colors.black,
                child: CustomImage(
                    imageType: ImageType.SVG_LOCAL,
                    imageUrl: AppSvgs.ARROW_UP,
                    color: AppColors.lightSteel1,
                    onClick: () => searchController.animateToTop())),
            secondChild: const SizedBox.shrink(),
            crossFadeState: searchState.crossFadeState
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300)));
  }
}
