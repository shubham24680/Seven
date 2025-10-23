import 'package:seven/app/app.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(showsProvider);
    final searchController = ref.read(showsProvider.notifier);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.SIDE_PADDING),
        child: Column(children: [
          Row(children: [
            Expanded(
                flex: 4,
                child: CustomTextField(
                    textFieldType: TextFieldType.INPUT,
                    onChanged: (value) {
                      searchController.readyToSearch(value?.isNotEmpty);
                    },
                    filled: true,
                    controller: searchState.searchController,
                    hintText: "Search movies")),
            if (searchState.searchValueExist) ...[
              SizedBox(width: 0.02.sw),
              Expanded(
                  child: CustomButton(
                      buttonType: ButtonType.ELEVATED,
                      onPressed: () => searchController.searchResult(),
                      height: 0.065.sh,
                      backgroundColor: AppColors.vividNightfall4,
                      child: CustomText(text: "Go", weight: FontWeight.w900)))
            ]
          ]),
          CustomCollection(
            collectionName: "Search",
            isLoading: false,
            result: searchState.search.results,
          )
        ]),
      ).onTap(event: () => FocusScope.of(context).unfocus()),
    );
  }
}
