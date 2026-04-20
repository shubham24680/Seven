import 'package:seven/app/app.dart';

class DetailCollectionScreen extends ConsumerWidget {
  const DetailCollectionScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(showCollectionDetailProvider(id));
    final title = collection.value?.title;
    final collectionName =
        (collection.hasError || title == null || title.isEmpty)
            ? "More in the Series"
            : title;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppBar(() => context.pop(), collectionName),
        body: collection.when(
            data: (detail) {
              final parts = detail.parts;

              return CustomCollection(
                      scrollDirection: Axis.vertical,
                      orientation: CardOrientation.POTRAIT,
                      crossAxisCount: 2,
                      loadingItemCount: 2,
                      isSafeHeight: true,
                      isLoading: false,
                      results: parts)
                  .padding(top: AppConstants.SIDE_PADDING);
            },
            error: (_, __) => ErrorScreen(
                goBack: false,
                onPressed: () =>
                    ref.invalidate(showCollectionDetailProvider(id))),
            loading: () => Center(
                child: CircularProgressIndicator(
                    color: AppColors.vividNightfall4,
                    strokeCap: StrokeCap.round))));
  }
}
