import 'dart:developer';
import 'package:seven/app/app.dart';

// enum ShowType { SHOWS, GENRES }

// STATE
class ShowsState {
  final ShowsModel shows;
  final GenreModel genre;
  final List<ShowsModel> collection;
  final Network status;
  final int navigationCurrentIndex;
  final int carouselCurrentIndex;

  const ShowsState({
    required this.shows,
    required this.genre,
    required this.collection,
    required this.status,
    required this.navigationCurrentIndex,
    required this.carouselCurrentIndex,
  });

  factory ShowsState.initial() {
    return ShowsState(
      shows: ShowsModel(),
      genre: GenreModel(),
      collection: AppConstants.COLLECTIONS.map((item) => ShowsModel()).toList(),
      status: Network(),
      navigationCurrentIndex: 0,
      carouselCurrentIndex: 0,
    );
  }

  ShowsState copyWith({
    ShowsModel? shows,
    GenreModel? genre,
    List<ShowsModel>? collection,
    Network? status,
    int? navigationCurrentIndex,
    int? carouselCurrentIndex,
    bool? isRefreshing,
  }) {
    return ShowsState(
      shows: shows ?? this.shows,
      genre: genre ?? this.genre,
      collection: collection ?? this.collection,
      status: status ?? this.status,
      navigationCurrentIndex:
          navigationCurrentIndex ?? this.navigationCurrentIndex,
      carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
    );
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial()) {
    loadAllData();
  }

  // final Map<ShowType, DateTime> _lastFetchTimes = {};
  // static const Duration _cacheTimeout = Duration(minutes: 5);

  // SHOWS
  Future<void> loadShows({bool forceRefresh = false}) async {
    if (state.shows.isLoading) return;

    // if (!forceRefresh && _isDataCached(ShowType.SHOWS)) return;

    state = state.copyWith(
      shows: state.shows.setApiStatus(ApiStatus.LOADING),
    );

    log("Fetching shows data");
    final shows = await ShowsServices.instance.fetchShows();
    final genre = await ShowsServices.instance.fetchGenres();

    if (shows != null && shows.results?.firstOrNull != null) {
      // _updateCache(ShowType.SHOWS);
      state = state.copyWith(
        shows: shows.setApiStatus(ApiStatus.SUCCESS,
            successMessage: "Shows loaded successfully)"),
        genre: genre,
      );
      log("Shows loaded successfully: ${shows.results!.length} items");
    } else {
      state = state.copyWith(
          shows: state.shows
              .setApiStatus(ApiStatus.ERROR, errorMessage: "No Shows to fetch"),
          status: state.status.count());
      log("No shows data received - ${state.status.apiErrorCount}");
    }
  }

  // COLLECTIONS
  Future<void> loadCollections({bool forceRefresh = false}) async {
    for (int index = 0; index < state.collection.length; index++) {
      log("Collection $index Loading -> ${state.collection[index].apiStatus}");
      if (state.collection[index].isLoading) return;
    }

    state = state.copyWith(
        collection: state.collection
            .map((c) => c.setApiStatus(ApiStatus.LOADING))
            .toList());

    log("Fetching collections data");
    List<ShowsModel?>? collection;
    for (int attempt = 1; attempt <= 5; attempt++) {
      collection = await ShowsServices.instance.fetchCollections();
      if (collection != null) {
        log("Collections fetched successfully on attempt $attempt");
        break;
      }
      log("Collections fetch attempt $attempt failed (null). Retrying...");
      await Future.delayed(Duration(seconds: attempt));
    }

    if (collection != null) {
      state = state.copyWith(
        collection: collection.map((c) {
          if (c == null) {
            return ShowsModel().setApiStatus(ApiStatus.ERROR,
                errorMessage: "No Collection to fetch");
          }

          return c.setApiStatus(ApiStatus.SUCCESS,
              successMessage: "Collection loaded successfully)");
        }).toList(),
      );
      log("Collection loaded successfully");
    } else {
      state = state.copyWith(
          collection: state.collection
              .map((c) => c.setApiStatus(ApiStatus.ERROR,
                  errorMessage: "No Collection to fetch"))
              .toList(),
          status: state.status.count(count: state.collection.length));
      log("No collection data received - ${state.status.apiErrorCount}");
    }
  }

  // LOAD ALL DATA
  Future<void> loadAllData({bool forceRefresh = false}) async {
    if (state.status.isLoading) return;

    log("Loading all data concurrently");
    state = state.copyWith(status: state.status.defaultCount());
    state =
        state.copyWith(status: state.status.setApiStatus(ApiStatus.LOADING));

    try {
      await Future.wait([
        loadShows(forceRefresh: forceRefresh),
        loadCollections(forceRefresh: forceRefresh),
      ]);
    } finally {
      state = state.copyWith(
          status: state.status.setApiStatus(
              state.status.apiErrorCount >= state.collection.length + 1
                  ? ApiStatus.ERROR
                  : ApiStatus.SUCCESS));
    }
  }

  Future<void> refresh() async {
    log("Refreshing all data");
    state.status.defaultCount();
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

  // bool _isDataCached(ShowType key) {
  //   final lastFetch = _lastFetchTimes[key];
  //   if (lastFetch == null) return false;
  //   return DateTime.now().difference(lastFetch) < _cacheTimeout;
  // }

  // // Update cache timestamp
  // void _updateCache(ShowType key) {
  //   _lastFetchTimes[key] = DateTime.now();
  // }

  // // Clear cache (useful for testing or manual cache invalidation)
  // void clearCache() {
  //   _lastFetchTimes.clear();
  //   log("Cache cleared");
  // }
}

/// Optimized provider with auto-dispose and better memory management
final showsProvider = StateNotifierProvider<ShowsProvider, ShowsState>(
  (ref) => ShowsProvider(),
);
