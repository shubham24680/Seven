import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:seven/app/app.dart';

abstract class ShowNotifier extends AsyncNotifier<List<Result>> {
  int _currentPage = 1;
  bool _hasMorePages = true;
  Future<ShowsModel> fetchShows(int page);
  StorageKey key;

  ShowNotifier(this.key);

  @override
  Future<List<Result>> build() async {
    final storage = await SPD.getInstance();
    try {
      final cache = storage.get<Map<String, dynamic>>(key);
      if (cache != null) {
        final cacheData = ShowsModel.fromJson(cache);
        AsyncData(cacheData);
      }

      final response = await fetchShows(_currentPage);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;

      await storage.set(key, response.toJson());
      return response.results ?? [];
    } on ApiException catch (_) {
      final cache = storage.get<Map<String, dynamic>>(key);
      if (cache != null) {
        final cacheData = ShowsModel.fromJson(cache);
        return cacheData.results ?? [];
      }
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return build();
    });
  }

  Future<void> loadMore() async {
    if (!_hasMorePages || state.isLoading) return;

    final currentShows = state.valueOrNull ?? [];
    state = await AsyncValue.guard(() async {
      try {
        _currentPage++;
        final response = await fetchShows(_currentPage);
        final totalPages = response.totalPages?.toInt();
        if (totalPages != null) _hasMorePages = _currentPage < totalPages;
        return [...currentShows, ...response.results ?? []];
      } on ApiException catch (_) {
        _currentPage--;
        return currentShows;
      }
    });
  }
}

class TrendingShowNotifier extends ShowNotifier {
  TrendingShowNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchTrendingShows(page: page);
  }
}

final trendingShowProvider =
    AsyncNotifierProvider<TrendingShowNotifier, List<Result>>(
  () => TrendingShowNotifier(StorageKey.TRENDING),
);

class TopShowNotifier extends ShowNotifier {
  TopShowNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchTopShows(page: page);
  }
}

final topShowsProvider = AsyncNotifierProvider<TopShowNotifier, List<Result>>(
  () => TopShowNotifier(StorageKey.TOP_SHOWS),
);

class NewReleaseShowsNotifier extends ShowNotifier {
  NewReleaseShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchNewReleaseShows(page: page);
  }
}

final newReleaseShowsProvider =
    AsyncNotifierProvider<NewReleaseShowsNotifier, List<Result>>(
  () => NewReleaseShowsNotifier(StorageKey.NEW_RELEASE),
);

class UpcomingShowsNotifier extends ShowNotifier {
  UpcomingShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchUpcomingShows(page: page);
  }
}

final upcomingShowsProvider =
    AsyncNotifierProvider<UpcomingShowsNotifier, List<Result>>(
  () => UpcomingShowsNotifier(StorageKey.UPCOMING),
);

class AllTimeClassicShowsNotifier extends ShowNotifier {
  AllTimeClassicShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchAllTimeClassicShows(page: page);
  }
}

final allTimeClassicShowsProvider =
    AsyncNotifierProvider<AllTimeClassicShowsNotifier, List<Result>>(
  () => AllTimeClassicShowsNotifier(StorageKey.ALL_TIME_CLASSIC),
);

class PopularInIndiaShowsNotifier extends ShowNotifier {
  PopularInIndiaShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchPopularInIndiaShows(page: page);
  }
}

final popularInIndiaShowsProvider =
    AsyncNotifierProvider<PopularInIndiaShowsNotifier, List<Result>>(
  () => PopularInIndiaShowsNotifier(StorageKey.POPULAR_IN_INDIA),
);

class OnTheAirTVShowsNotifier extends ShowNotifier {
  OnTheAirTVShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchOnTheAirTVShows(page: page);
  }
}

final onTheAirTVShowsNotifier =
AsyncNotifierProvider<OnTheAirTVShowsNotifier, List<Result>>(
      () => OnTheAirTVShowsNotifier(StorageKey.ON_THE_AIR),
);

class AiringTodayTVShowsNotifier extends ShowNotifier {
  AiringTodayTVShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchAiringTodayTVShows(page: page);
  }
}

final airingTodayTVShowsNotifier =
AsyncNotifierProvider<AiringTodayTVShowsNotifier, List<Result>>(
      () => AiringTodayTVShowsNotifier(StorageKey.AIRING_TODAY_TV),
);

class PopularTVShowsNotifier extends ShowNotifier {
  PopularTVShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = ShowsServices.instance;
    return service.fetchPopularTVShows(page: page);
  }
}

final popularTVShowsNotifier =
AsyncNotifierProvider<PopularTVShowsNotifier, List<Result>>(
      () => PopularTVShowsNotifier(StorageKey.POPULAR_TV),
);

// STATE
class ShowsState {
  final int navigationCurrentIndex;
  final int carouselCurrentIndex;
  final Result? genres;
  final ScrollController scrollController;
  final bool crossFadeState;

  const ShowsState(
      {required this.navigationCurrentIndex,
      required this.carouselCurrentIndex,
      this.genres,
      required this.scrollController,
      required this.crossFadeState});

  factory ShowsState.initial() {
    return ShowsState(
        navigationCurrentIndex: 0,
        carouselCurrentIndex: 0,
        scrollController: ScrollController(),
        crossFadeState: false);
  }

  ShowsState copyWith(
      {int? navigationCurrentIndex,
      int? carouselCurrentIndex,
      Result? genres,
      bool? crossFadeState}) {
    return ShowsState(
        navigationCurrentIndex:
            navigationCurrentIndex ?? this.navigationCurrentIndex,
        carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
        genres: genres ?? this.genres,
        scrollController: scrollController,
        crossFadeState: crossFadeState ?? this.crossFadeState);
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial()) {
    _loadData();
    // _getNative();
    state.scrollController.addListener(_onScroll);
  }

  Future<void> _loadData() async {
    final storage = await SPD.getInstance();

    try {
      final key = StorageKey.GENRES;
      final cache = storage.get<Map<String, dynamic>>(key);
      if (cache != null) {
        final cacheData = Result.fromJson(cache);
        state = state.copyWith(genres: cacheData);
      }

      final service = ShowsServices.instance;
      final genres = await service.fetchGenres();
      await storage.set(key, genres.toJson());
      state = state.copyWith(genres: genres);
    } on ApiException catch (e) {
      log("Genre Exception -> $e");
    } catch (e) {
      log("Genre Error -> $e");
    }
  }

  Future<void> _getNative() async {
    try {
      final deviceName = await NativeBridge.getDeviceName();
      log("Device name -> $deviceName");
    } catch (e) {
      log("Native Exception -> $e");
    }
  }

  void _onScroll() {
    final crossFadeState =
        state.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse;
    state = state.copyWith(crossFadeState: crossFadeState);
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
