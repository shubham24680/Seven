import 'dart:developer';

import 'package:seven/app/app.dart';
import 'package:seven/providers/collection_providers.dart';

// class CollectionScreen extends ConsumerStatefulWidget {
//   const CollectionScreen(
//       {super.key,
//       required this.collectionName,
//       required this.collectionProvider});

//   final String collectionName;
//   final AsyncNotifierProvider<ShowNotifier, List<Result>> collectionProvider;

//   @override
//   ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
// }

// class _CollectionScreenState extends ConsumerState<CollectionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final collection = ref.watch(widget.collectionProvider);
//     final isBottomState = ref.watch(provider);
//     final isBottomController = ref.read(provider.notifier);

//     if (isBottomState.isBottom && !isBottomState.isLoading) {
//       log("Hit");
//       Future.microtask(() async {
//         isBottomController.loading(true);
//         await ref.read(widget.collectionProvider.notifier).loadMore();
//         isBottomController.loading(false);
//       });
//     }

//     return Scaffold(
//       appBar: customAppBar(() => context.pop(), widget.collectionName),
//       body: collection.when(
//         data: (data) => CustomCollection(
//           scrollController: isBottomState.scrollController,
//           scrollDirection: Axis.vertical,
//           orientation: CardOrientation.POTRAIT,
//           crossAxisCount: 2,
//           loadingItemCount: 2,
//           isSafeHeight: true,
//           isLoading: isBottomState.isLoading,
//           results: data,
//         ),
//         loading: () => CustomCollection(
//           scrollDirection: Axis.vertical,
//           orientation: CardOrientation.POTRAIT,
//           crossAxisCount: 2,
//           loadingItemCount: 2,
//         ),
//         error: (error, stackTrace) => const SizedBox.shrink(),
//       ),
//     );
//   }
// }

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
