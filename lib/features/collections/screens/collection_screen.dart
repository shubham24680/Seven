import 'package:seven/app/app.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen(
      {super.key,
      required this.collectionName,
      required this.collectionProvider});

  final String collectionName;
  final AsyncNotifierProvider<ShowNotifier, List<Result>> collectionProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionProvider);
    final isBottomState = ref.watch(provider(collectionProvider));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(() => context.pop(), collectionName),
      body: collection.when(
        data: (data) => CustomCollection(
          scrollController: isBottomState.scrollController,
          scrollDirection: Axis.vertical,
          orientation: CardOrientation.POTRAIT,
          crossAxisCount: 2,
          loadingItemCount: 2,
          isSafeHeight: true,
          isLoading: isBottomState.isLoading,
          results: data,
        ),
        loading: () => CustomCollection(
          scrollDirection: Axis.vertical,
          orientation: CardOrientation.POTRAIT,
          crossAxisCount: 2,
          loadingItemCount: 2,
        ),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
