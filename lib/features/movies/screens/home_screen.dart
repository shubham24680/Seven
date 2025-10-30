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
            final showsState = ref.watch(showsProvider);
            final showsController = ref.read(showsProvider.notifier);

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    List.generate(ApiConstants.COLLECTIONS.length, (index) {
                  final collection = showsState.collection[index];
                  final isLoading = collection.isLoading;
                  final isError = collection.isError;

                  if (isError ||
                      (!isLoading && collection.results?.firstOrNull == null)) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          const Divider(
                            color: AppColors.black2,
                          ).paddingSymmetric(
                              horizontal: AppConstants.SIDE_PADDING),
                        CustomCollection(
                          collectionName: AppConstants.COLLECTIONS[index],
                          isLoading: isLoading,
                          results: collection.results,
                          onPressed: () {
                            showsController.chooseTo(index);
                            context.push("/collection");
                          },
                        )
                      ]);
                }));
          })
        ]));
  }
}
