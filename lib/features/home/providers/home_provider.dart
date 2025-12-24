import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:seven/app/app.dart';

abstract class ShowNotifier extends AsyncNotifier<List<Result>> {
  int _currentPage = 1;
  bool _hasMorePages = true;

  Future<ShowsModel> fetchShows(int page);

  String key;

  ShowNotifier(this.key);

  @override
  Future<List<Result>> build() async {
    final storage = await SPD.getInstance();
    try {
      final cache = storage.getCache(key);
      if (cache != null) {
        final cacheData = ShowsModel.fromJson(cache);
        AsyncData(cacheData);
      }

      final response = await fetchShows(_currentPage);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;

      await storage.setCache(key, response.toJson());
      return response.results ?? [];
    } on ApiException catch (_) {
      final cache = storage.getCache(key);
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
    final service = HomeServices.instance;
    return service.fetchTrendingShows(page: page);
  }
}

final trendingShowProvider =
    AsyncNotifierProvider<TrendingShowNotifier, List<Result>>(
  () => TrendingShowNotifier(StorageConstants.TRENDING),
);

class TopShowNotifier extends ShowNotifier {
  TopShowNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = HomeServices.instance;
    return service.fetchTopShows(page: page);
  }
}

final topShowsProvider = AsyncNotifierProvider<TopShowNotifier, List<Result>>(
  () => TopShowNotifier(StorageConstants.TOP_20_MOVIES),
);

class NewReleaseShowsNotifier extends ShowNotifier {
  NewReleaseShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = HomeServices.instance;
    return service.fetchNewReleaseShows(page: page);
  }
}

final newReleaseShowsProvider =
    AsyncNotifierProvider<NewReleaseShowsNotifier, List<Result>>(
  () => NewReleaseShowsNotifier(StorageConstants.NEW_RELEASE),
);

class UpcomingShowsNotifier extends ShowNotifier {
  UpcomingShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = HomeServices.instance;
    return service.fetchUpcomingShows(page: page);
  }
}

final upcomingShowsProvider =
    AsyncNotifierProvider<UpcomingShowsNotifier, List<Result>>(
  () => UpcomingShowsNotifier(StorageConstants.UPCOMING),
);

class AllTimeClassicShowsNotifier extends ShowNotifier {
  AllTimeClassicShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = HomeServices.instance;
    return service.fetchAllTimeClassicShows(page: page);
  }
}

final allTimeClassicShowsProvider =
    AsyncNotifierProvider<AllTimeClassicShowsNotifier, List<Result>>(
  () => AllTimeClassicShowsNotifier(StorageConstants.ALL_TIME_CLASSIC),
);

class PopularInIndiaShowsNotifier extends ShowNotifier {
  PopularInIndiaShowsNotifier(super.key);

  @override
  Future<ShowsModel> fetchShows(int page) async {
    final service = HomeServices.instance;
    return service.fetchPopularInIndiaShows(page: page);
  }
}

final popularInIndiaShowsProvider =
    AsyncNotifierProvider<PopularInIndiaShowsNotifier, List<Result>>(
  () => PopularInIndiaShowsNotifier(StorageConstants.POPULAR_IN_INDIA),
);

// STATE
class ShowsState {
  final Model screens;
  final int carouselCurrentIndex;
  final Result? genres;
  final ScrollController scrollController;
  final bool crossFadeState;

  const ShowsState(
      {required this.screens,
      required this.carouselCurrentIndex,
      this.genres,
      required this.scrollController,
      required this.crossFadeState});

  factory ShowsState.initial() {
    return ShowsState(
        screens: Model(),
        carouselCurrentIndex: 0,
        scrollController: ScrollController(),
        crossFadeState: false);
  }

  ShowsState copyWith(
      {Model? screens,
      int? navigationCurrentIndex,
      int? carouselCurrentIndex,
      Result? genres,
      bool? crossFadeState}) {
    return ShowsState(
        screens: screens ?? this.screens,
        carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
        genres: genres ?? this.genres,
        scrollController: scrollController,
        crossFadeState: crossFadeState ?? this.crossFadeState);
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial()) {
    _loadData();
    state.scrollController.addListener(_onScroll);
  }

  double? _lastPixels;
  double _accumulatedDelta = 0.0;
  static const double _scrollThreshold = 90.0;


  Future<void> _loadData() async {
    final storage = await SPD.getInstance();
    try {
      final cache = storage.getCache(StorageConstants.HOME);
      if (cache != null) {
        state = state.copyWith(screens: Model.fromJson(cache));
      }

      final screens = await HomeServices.instance.fetchHomeScreenData();
      state = state.copyWith(screens: screens);

      await storage.setCache(StorageConstants.HOME, screens.toJson());
    } on ApiException catch (e) {
      log(" [HomeProvider] Exception -> $e");
    }
  }

  // Future<void> _loadData() async {
  //   final storage = await SPD.getInstance();
  //
  //   try {
  //     final key = StorageConstants.GENRES;
  //     final cache = storage.getCache(key);
  //     if (cache != null) {
  //       final cacheData = Result.fromJson(cache);
  //       state = state.copyWith(genres: cacheData);
  //     }
  //
  //     final service = HomeServices.instance;
  //     final genres = await service.fetchGenres();
  //     await storage.setShows(key, genres.toJson());
  //     state = state.copyWith(genres: genres);
  //   } on ApiException catch (e) {
  //     log("Genre Exception -> $e");
  //   } catch (e) {
  //     log("Genre Error -> $e");
  //   }
  // }

  void _onScroll() {
    if (!state.scrollController.hasClients) return;

    final position =  state.scrollController.position;
    final currentPixel = position.pixels;
    final delta = currentPixel - (_lastPixels ?? currentPixel);
    _lastPixels = currentPixel;
    log("CHANGE - $delta");
    if(delta.abs() < 2.0) return;

    if ((_accumulatedDelta > 0 && delta < 0) ||
        (_accumulatedDelta < 0 && delta > 0)) {
      _accumulatedDelta = 0;
    }

    _accumulatedDelta += delta;
    if ((_accumulatedDelta > _scrollThreshold) && !state.crossFadeState) {
      state = state.copyWith(crossFadeState: true);
    }
    if ((_accumulatedDelta < -(_scrollThreshold * 2.0)) && state.crossFadeState) {
      state = state.copyWith(crossFadeState: false);
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
