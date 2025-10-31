import 'package:seven/app/app.dart';

abstract class ResultNotifier extends FamilyAsyncNotifier<Result, String> {
  Future<Result> fetchResult(String id);

  @override
  Future<Result> build(String id) async {
    try {
      final response = await fetchResult(id);
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> refresh() async {
    final id = arg;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await build(id);
      return result;
    });
  }
}

class ShowDetailNotifier extends ResultNotifier {
  @override
  Future<Result> fetchResult(String showId) {
    final service = ShowsServices.instance;
    return service.fetchShowDetail(showId);
  }
}

final showDetailProvider =
    AsyncNotifierProviderFamily<ShowDetailNotifier, Result, String>(
        ShowDetailNotifier.new);

class ShowCollectionNotifier extends ResultNotifier {
  @override
  Future<Result> fetchResult(String showId) async {
    final showDetail = await ref.watch(showDetailProvider(showId).future);
    final collectionId = showDetail.belongsToCollection?.id.toString();
    if (collectionId == null) throw Exception("No Collection");

    final service = ShowsServices.instance;
    return service.fetchCollectionDetail(collectionId);
  }
}

final showCollectionProvider =
    AsyncNotifierProviderFamily<ShowCollectionNotifier, Result, String>(
        ShowCollectionNotifier.new);
