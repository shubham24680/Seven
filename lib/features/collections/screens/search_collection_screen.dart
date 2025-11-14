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
                  searchController.readyToSearch(value?.isNotEmpty),
              filled: true,
              autofocus: true,
              hintText: "Search movies",
              perfixIcon: CustomImage(
                  imageType: ImageType.SVG_LOCAL,
                  imageUrl: AppSvgs.ARROW_LEFT,
                  color: AppColors.lightSteel1.withAlpha(40),
                  event: () => context.pop()))),
      if (searchState.searchValueExist) ...[
        SizedBox(width: 0.02.sw),
        Expanded(
            child: CustomButton(
                buttonType: ButtonType.ELEVATED,
                onPressed: () =>
                    controller.search(searchState.searchController.text),
                height: 0.065.sh,
                backgroundColor: AppColors.vividNightfall4,
                child: CustomText(text: "Go", weight: FontWeight.w900)))
      ]
    ]).paddingSymmetric(vertical: AppConstants.SIDE_PADDING);

    final borderRadius = BorderRadius.circular(0.015.sh);
    final appbar = SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0.095.sh,
      snap: true,
      floating: true,
      title: firstChild,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      flexibleSpace: blurEffect(
          20.0, Container(color: AppColors.black3.withAlpha(200)),
          borderRadius: borderRadius),
    );

    return Scaffold(
        body: CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
      appbar,
      SliverToBoxAdapter(
          child: Flexible(
              child: search.when(
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
                      Center(child: CustomText(text: "No Result")))))
    ]).onTap(event: () => FocusScope.of(context).unfocus()));
  }
}
