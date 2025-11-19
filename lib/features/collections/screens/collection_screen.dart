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
    final isBottomController = ref.read(provider(collectionProvider).notifier);

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
                results: data),
            loading: () => CustomCollection(
                scrollDirection: Axis.vertical,
                orientation: CardOrientation.POTRAIT,
                crossAxisCount: 2,
                loadingItemCount: 2),
            error: (error, stackTrace) => const SizedBox.shrink()),
        floatingActionButton: AnimatedCrossFade(
            firstChild: FloatingActionButton.small(
                onPressed: () => isBottomController.animateToTop(),
                backgroundColor: AppColors.vividNightfall4,
                elevation: 3,
                focusColor: Colors.black,
                child: CustomImage(
                    imageType: ImageType.SVG_LOCAL,
                    imageUrl: AppSvgs.ARROW_UP,
                    color: AppColors.lightSteel1,
                    onClick: () => isBottomController.animateToTop())),
            secondChild: const SizedBox.shrink(),
            crossFadeState: isBottomState.crossFadeState
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300)));
  }
}
