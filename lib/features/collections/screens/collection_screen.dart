import 'package:seven/app/app.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen(
      {super.key, required this.id, required this.collectionName});

  final String id;
  final String collectionName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionProvider(id));

    return Scaffold(
      appBar: customAppBar(() => context.pop(), collectionName),
      body: collection.when(
        data: (data) => CustomCollection(
          scrollDirection: Axis.vertical,
          orientation: CardOrientation.POTRAIT,
          crossAxisCount: 2,
          isSafeHeight: true,
          isLoading: false,
          results: data,
        ),
        loading: () => CustomCollection(collectionName: collectionName),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
