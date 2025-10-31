import 'package:seven/app/app.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionState = ref.watch(showsProvider);
    final collectionController = ref.read(showsProvider.notifier);
    // final results =
    //     collectionState.collection[collectionState.showsIndex].results;
    // final appBarTitle = AppConstants.COLLECTIONS[collectionState.showsIndex];

    return Scaffold(
      appBar: customAppBar(() => context.pop(), "appBarTitle"),
      // body: CustomCollection(
      //   isLoading: collectionState.shows.isLoading,
      //   orientation: CardOrientation.POTRAIT,
      //   isSafeHeight: true,
      //   crossAxisCount: 2,
      //   scrollDirection: Axis.vertical,
      //   results: results,
      // ),
    );
  }
}
