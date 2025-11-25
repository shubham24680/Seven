import 'package:seven/app/app.dart';

class SearchCollectionScreen extends ConsumerWidget {
  const SearchCollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider(searchWithTitle));
    final searchController = ref.read(searchProvider(searchWithTitle).notifier);
    final search = ref.watch(searchWithTitle);
    final controller = ref.read(searchWithTitle.notifier);
    final options = AppConstants.GENRES;

    final title = Row(children: [
      Expanded(
          flex: 4,
          child: CustomTextField(
              controller: searchState.searchController,
              onChanged: (value) =>
                  searchController.readyToSearch(value?.isNotEmpty),
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
                onPressed: () => controller.search(
                    searchState.searchController.text,
                    searchState.selectedGrenre),
                height: 0.065.sh,
                backgroundColor: AppColors.vividNightfall4,
                child: CustomText(text: "Go", weight: FontWeight.w900)))
      ]
    ]);
    final bottomOption = PreferredSize(
        preferredSize: Size.fromHeight(0.06.sh),
        child: SizedBox(
            height: 0.06.sh,
            child: ListView.builder(
                itemCount: options.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: AppConstants.SIDE_PADDING),
                itemBuilder: (context, index) {
                  final genre = options[index].title ?? "";
                  final id = options[index].id ?? -1;

                  return ChoiceChip(
                          label: CustomText(
                              text: genre,
                              size: 0.015.sh,
                              color: AppColors.lightSteel1,
                              weight: FontWeight.w900),
                          onSelected: (selected) {
                            if (selected) {
                              searchController.addChoice(id);
                            } else {
                              searchController.removeChoice(id);
                            }
                          },
                          selected: searchState.selectedGrenre.contains(id),
                          showCheckmark: false,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          backgroundColor: AppColors.transparent,
                          selectedColor: AppColors.vividNightfall4,
                          side: BorderSide(color: AppColors.vividNightfall4))
                      .paddingFromLTRB(right: AppConstants.SIDE_PADDING);
                })));

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0.065.sh,
            title: title,
            bottom: bottomOption,
            flexibleSpace: blurEffect(
                20.0, Container(color: AppColors.black3.withAlpha(200)))),
        body: search
            .when(
                data: (data) {
                  if (data == null) return const SizedBox.shrink();
                  if (data.isEmpty) {
                    return ErrorScreen(
                        type: Type.TYPE2,
                        goBack: true,
                        image: AppSvgs.NO_RESULT,
                        heading: "Oops!",
                        description: "No Results Found");
                  }

                  return CustomCollection(
                      scrollController: searchState.scrollController,
                      scrollDirection: Axis.vertical,
                      orientation: CardOrientation.POTRAIT,
                      isSafeHeight: true,
                      isLoading: searchState.isLoading,
                      crossAxisCount: 2,
                      loadingItemCount: 2,
                      results: data);
                },
                loading: () => CustomCollection(
                    scrollDirection: Axis.vertical,
                    orientation: CardOrientation.POTRAIT,
                    isSafeHeight: true,
                    crossAxisCount: 2,
                    loadingItemCount: 2),
                error: (error, stackTrace) =>
                    ErrorScreen(type: Type.TYPE2, goBack: true))
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
