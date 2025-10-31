import 'dart:developer';
import 'package:seven/app/app.dart';

abstract class ShowNotifier extends AutoDisposeAsyncNotifier<List<Result>> {
  int _currentPage = 1;
  bool _hasMorePages = true;

  Future<ShowsModel> fetchShows(int page);

  @override
  Future<List<Result>> build() async {
    final result = await load();
    return result ?? [];
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return build();
    });
  }

  Future<void> loadMore() async {
    if (!_hasMorePages || state.isLoading) return;

    _currentPage++;
    final currentShows = state.valueOrNull ?? [];
    state = await AsyncValue.guard(() async {
      final result = await load();
      return [...currentShows, ...result ?? []];
    });
  }

  Future<List<Result>?> load() async {
    try {
      final response = await fetchShows(_currentPage);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;
      return response.results;
    } on ApiException catch (e) {
      rethrow;
    }
  }
}

class TrendingShowNotifier extends ShowNotifier {
  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchTrendingShows(page: page);
  }
}

final trendingShowProvider =
    AutoDisposeAsyncNotifierProvider<TrendingShowNotifier, List<Result>>(
  () => TrendingShowNotifier(),
);

class TopShowNotifier extends ShowNotifier {
  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchTopShows(page: page);
  }
}

final topShowsProvider =
    AutoDisposeAsyncNotifierProvider<TopShowNotifier, List<Result>>(
  () => TopShowNotifier(),
);

class NewReleaseShowsNotifier extends ShowNotifier {
  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchNewReleaseShows(page: page);
  }
}

final newReleaseShowsProvider =
    AutoDisposeAsyncNotifierProvider<NewReleaseShowsNotifier, List<Result>>(
  () => NewReleaseShowsNotifier(),
);

class UpcomingShowsNotifier extends ShowNotifier {
  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchUpcomingShows(page: page);
  }
}

final upcomingShowsProvider =
    AutoDisposeAsyncNotifierProvider<UpcomingShowsNotifier, List<Result>>(
  () => UpcomingShowsNotifier(),
);

final genreProvider = FutureProvider<Result>((ref) {
  final service = ShowsServices.instance;
  return service.fetchGenres();
});

// STATE
class ShowsState {
  final int navigationCurrentIndex;
  final int carouselCurrentIndex;
  final Result? genres;

  const ShowsState({
    required this.navigationCurrentIndex,
    required this.carouselCurrentIndex,
    this.genres,
  });

  factory ShowsState.initial() {
    return ShowsState(navigationCurrentIndex: 0, carouselCurrentIndex: 0);
  }

  ShowsState copyWith(
      {int? navigationCurrentIndex,
      int? carouselCurrentIndex,
      Result? genres}) {
    return ShowsState(
        navigationCurrentIndex:
            navigationCurrentIndex ?? this.navigationCurrentIndex,
        carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
        genres: genres ?? this.genres);
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial()) {
    _loadData();
  }

  Future<void> _loadData() async {
    final service = ShowsServices.instance;
    final genres = await service.fetchGenres();

    try {
      state = state.copyWith(genres: genres);
    } on ApiException catch (e) {
      log("Genre Exception -> $e");
    } catch (e) {
      log("Genre Error -> $e");
    }
  }

  // Update navigation index with validation
  void moveToPage(int index) {
    log("Moving to page: $index");
    if (index < 0) {
      log("Invalid navigation index: $index");
      return;
    }
    state = state.copyWith(navigationCurrentIndex: index);
    log("Navigation index updated: $index");
  }

  // Update carousel index with validation
  void nextTo(int index) {
    if (index < 0) {
      log("Invalid carousel index: $index");
      return;
    }
    state = state.copyWith(carouselCurrentIndex: index);
  }
}

final showsProvider =
    StateNotifierProvider<ShowsProvider, ShowsState>((ref) => ShowsProvider());
