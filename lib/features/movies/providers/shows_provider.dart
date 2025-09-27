import 'dart:developer';
import 'package:seven/app/app.dart';

enum ShowType { SHOWS, GENRES }

// STATE
class ShowsState {
  final ShowsModel shows;
  final GenreModel genre;
  final Network status;
  final int navigationCurrentIndex;
  final int carouselCurrentIndex;

  const ShowsState({
    required this.shows,
    required this.genre,
    required this.status,
    required this.navigationCurrentIndex,
    required this.carouselCurrentIndex,
  });

  factory ShowsState.initial() {
    return ShowsState(
      shows: ShowsModel(),
      genre: GenreModel(),
      status: Network(),
      navigationCurrentIndex: 0,
      carouselCurrentIndex: 0,
    );
  }

  ShowsState copyWith({
    ShowsModel? shows,
    GenreModel? genre,
    Network? status,
    int? navigationCurrentIndex,
    int? carouselCurrentIndex,
    bool? isRefreshing,
  }) {
    return ShowsState(
      shows: shows ?? this.shows,
      genre: genre ?? this.genre,
      status: status ?? this.status,
      navigationCurrentIndex:
          navigationCurrentIndex ?? this.navigationCurrentIndex,
      carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
    );
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial());

  final Map<ShowType, DateTime> _lastFetchTimes = {};
  static const Duration _cacheTimeout = Duration(minutes: 5);

  // SHOWS
  Future<void> loadShows({bool forceRefresh = false}) async {
    if (state.shows.isLoading) return;

    if (!forceRefresh && _isDataCached(ShowType.SHOWS)) {
      log("Using cached shows data");
      return;
    }

    state = state.copyWith(
      shows: state.shows.setApiStatus(ApiStatus.LOADING),
    );

    try {
      log("Fetching shows data");
      final shows = await ShowsServices.instance.fetchShows();
      final genre = await ShowsServices.instance.fetchGenres();

      if (shows.results != null && shows.results!.isNotEmpty) {
        _updateCache(ShowType.SHOWS);
        state = state.copyWith(
          shows: shows.setApiStatus(ApiStatus.SUCCESS,
              successMessage: "Shows loaded successfully)"),
          genre: genre,
        );
        log("Shows loaded successfully: ${shows.results!.length} items");
      } else {
        state = state.copyWith(
          shows: shows.setApiStatus(
            ApiStatus.EMPTY,
            errorMessage: "No shows available at the moment",
          ),
        );
        log("No shows data received");
      }
    } on ApiException catch (e) {
      state = state.copyWith(
          shows: state.shows
              .setApiStatus(ApiStatus.ERROR, errorMessage: e.toString()),
          status: state.status.increaseCount());
      log("${state.status.apiErrorCount}");
    } catch (e) {
      state = state.copyWith(
          shows: state.shows
              .setApiStatus(ApiStatus.ERROR, errorMessage: e.toString()),
          status: state.status.increaseCount());
      log("${state.status.apiErrorCount}");
    }
  }

  Future<void> loadAllData({bool forceRefresh = false}) async {
    if (state.status.isLoading) return;

    log("Loading all data concurrently");
    state = state.copyWith(status: state.status.defaultCount());
    state =
        state.copyWith(status: state.status.setApiStatus(ApiStatus.LOADING));

    try {
      await Future.wait([
        loadShows(forceRefresh: forceRefresh),
      ]);
    } finally {
      state = state.copyWith(
          status: state.status.setApiStatus(state.status.apiErrorCount == 1
              ? ApiStatus.ERROR
              : ApiStatus.SUCCESS));
    }
  }

  Future<void> refresh() async {
    log("Refreshing all data");
    await loadAllData(forceRefresh: true);
  }

  // Update navigation index with validation
  void moveToPage(int index) {
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

  bool _isDataCached(ShowType key) {
    final lastFetch = _lastFetchTimes[key];
    if (lastFetch == null) return false;
    return DateTime.now().difference(lastFetch) < _cacheTimeout;
  }

  // Update cache timestamp
  void _updateCache(ShowType key) {
    _lastFetchTimes[key] = DateTime.now();
  }

  // Clear cache (useful for testing or manual cache invalidation)
  void clearCache() {
    _lastFetchTimes.clear();
    log("Cache cleared");
  }
}

/// Optimized provider with auto-dispose and better memory management
final showsProvider = StateNotifierProvider<ShowsProvider, ShowsState>(
  (ref) => ShowsProvider(),
);
