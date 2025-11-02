import 'package:seven/app/app.dart';

abstract class ResultNotifier extends FamilyAsyncNotifier<Result, String> {
  Future<Result> fetchResult(String id);

  @override
  Future<Result> build(String id) => fetchResult(id);

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchResult(arg));
  }
}

class ShowDetailNotifier extends ResultNotifier {
  @override
  Future<Result> fetchResult(String showId) =>
      ShowsServices.instance.fetchShowDetail(showId);
}

final showDetailProvider =
    AsyncNotifierProviderFamily<ShowDetailNotifier, Result, String>(
        ShowDetailNotifier.new);

class ShowCollectionDetailNotifier extends ResultNotifier {
  @override
  Future<Result> fetchResult(String collectionId) =>
      ShowsServices.instance.fetchCollectionDetail(collectionId);
}

final showCollectionDetailProvider =
    AsyncNotifierProviderFamily<ShowCollectionDetailNotifier, Result, String>(
        ShowCollectionDetailNotifier.new);

class ShowCollectionNotifier extends ResultNotifier {
  @override
  Future<Result> fetchResult(String showId) async {
    final showDetail = await ref.read(showDetailProvider(showId).future);
    final collectionId = showDetail.belongsToCollection?.id.toString();
    if (collectionId == null) throw Exception("No Collection");
    return ref.read(showCollectionDetailProvider(collectionId).future);
  }
}

final showCollectionProvider =
    AsyncNotifierProviderFamily<ShowCollectionNotifier, Result, String>(
        ShowCollectionNotifier.new);
