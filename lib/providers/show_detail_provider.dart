import 'package:seven/app/app.dart';

final showDetailProvider =
    FutureProvider.family<Result, String>((ref, showId) async {
  final service = ShowsServices.instance;
  return service.fetchShowDetail(showId);
});

final showCollectionProvider =
    FutureProvider.family<Result, String>((ref, showId) async {
  final showDetail = await ref.watch(showDetailProvider(showId).future);
  final collectionId = showDetail.belongsToCollection?.id.toString();
  if (collectionId == null) return Result();

  final service = ShowsServices.instance;
  return service.fetchCollectionDetail(collectionId);
});
