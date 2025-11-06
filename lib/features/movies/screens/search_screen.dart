import 'package:seven/app/app.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider(searchWithTitle));
    final searchController = ref.read(searchProvider(searchWithTitle).notifier);
    final search = ref.watch(searchWithTitle);
    final controller = ref.read(searchWithTitle.notifier);

    final firstChild = SafeArea(
      child: Row(children: [
        Expanded(
            flex: 4,
            child: CustomTextField(
                textFieldType: TextFieldType.INPUT,
                onChanged: (value) =>
                    searchController.readyToSearch(value?.isNotEmpty),
                filled: true,
                controller: searchState.searchController,
                hintText: "Search movies")),
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
        ],
      ]).paddingAll(AppConstants.SIDE_PADDING),
    );

    Widget buildResult() {
      return Flexible(
          child: search.when(
              data: (data) {
                return CustomCollection(
                  scrollController: searchState.scrollController,
                  orientation: CardOrientation.POTRAIT,
                  scrollDirection: Axis.vertical,
                  isSafeHeight: true,
                  isLoading: searchState.isLoading,
                  crossAxisCount: 2,
                  loadingItemCount: 2,
                  results: data,
                );
              },
              loading: () => CustomCollection(
                    orientation: CardOrientation.POTRAIT,
                    scrollDirection: Axis.vertical,
                    isSafeHeight: true,
                    crossAxisCount: 2,
                    loadingItemCount: 2,
                  ),
              error: (error, stackTrace) => const SizedBox.shrink()));
    }

    return Column(children: [
      AnimatedCrossFade(
          firstChild: firstChild,
          secondChild: const SizedBox.shrink(),
          crossFadeState: searchState.crossFadeState
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300)),
      buildResult()
    ]).onTap(
      event: () => FocusScope.of(context).unfocus(),
    );
  }
}
