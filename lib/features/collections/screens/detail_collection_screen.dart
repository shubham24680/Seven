import 'package:seven/app/app.dart';

class DetailCollectionScreen extends ConsumerWidget {
  const DetailCollectionScreen(
      {super.key,
      required this.collectionName,
      required this.detailCollection});

  final String collectionName;
  final List<Result> detailCollection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppBar(() => context.pop(), collectionName),
        body: CustomCollection(
            scrollDirection: Axis.vertical,
            orientation: CardOrientation.POTRAIT,
            crossAxisCount: 2,
            loadingItemCount: 2,
            isSafeHeight: true,
            isLoading: false,
            results: detailCollection));
  }
}
