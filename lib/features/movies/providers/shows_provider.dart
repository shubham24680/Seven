import 'dart:developer';
import 'package:seven/app/app.dart';

// enum ShowType { SHOWS, GENRES }

// STATE
class ShowsState {
  final ShowsModel shows;
  final Result showDetail;
  final GenreModel genre;
  final List<ShowsModel> collection;
  final ShowsModel search;
  final Network status;
  final int navigationCurrentIndex;
  final int carouselCurrentIndex;
  final TextEditingController searchController;
  final bool searchValueExist;
  final int showsIndex;

  const ShowsState(
      {required this.shows,
      required this.showDetail,
      required this.genre,
      required this.collection,
      required this.search,
      required this.status,
      required this.navigationCurrentIndex,
      required this.carouselCurrentIndex,
      required this.showsIndex,
      required this.searchController,
      required this.searchValueExist});

  factory ShowsState.initial() {
    return ShowsState(
        shows: ShowsModel(),
        showDetail: Result(),
        genre: GenreModel(),
        collection:
            ApiConstants.COLLECTIONS.map((item) => ShowsModel()).toList(),
        search: ShowsModel(),
        status: Network(),
        navigationCurrentIndex: 0,
        carouselCurrentIndex: 0,
        showsIndex: 0,
        searchController: TextEditingController(),
        searchValueExist: false);
  }

  ShowsState copyWith(
      {ShowsModel? shows,
      Result? showDetail,
      GenreModel? genre,
      List<ShowsModel>? collection,
      ShowsModel? search,
      Network? status,
      int? navigationCurrentIndex,
      int? carouselCurrentIndex,
      int? showsIndex,
      bool? isRefreshing,
      bool? searchValueExist}) {
    return ShowsState(
        shows: shows ?? this.shows,
        showDetail: showDetail ?? this.showDetail,
        genre: genre ?? this.genre,
        collection: collection ?? this.collection,
        search: search ?? this.search,
        status: status ?? this.status,
        navigationCurrentIndex:
            navigationCurrentIndex ?? this.navigationCurrentIndex,
        carouselCurrentIndex: carouselCurrentIndex ?? this.carouselCurrentIndex,
        showsIndex: showsIndex ?? this.showsIndex,
        searchController: searchController,
        searchValueExist: searchValueExist ?? this.searchValueExist);
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial()) {
    loadAllData();
  }

  // final Map<ShowType, DateTime> _lastFetchTimes = {};
  // static const Duration _cacheTimeout = Duration(minutes: 5);

  // SEARCH
  Future<void> searchResult() async {
    if (state.search.isLoading) return;

    // if (!forceRefresh && _isDataCached(ShowType.SHOWS)) return;

    state = state.copyWith(
      search: state.search.setApiStatus(ApiStatus.LOADING),
    );

    log("Fetching shows data");
    final searchResult =
        await ShowsServices.instance.search(state.searchController.text);

    if (searchResult != null && searchResult.results != null) {
      // _updateCache(ShowType.SHOWS);
      state = state.copyWith(
        search: searchResult.setApiStatus(ApiStatus.SUCCESS,
            successMessage: "Search loaded successfully)"),
      );
      log("Search loaded successfully: ${searchResult.results?.length}");
    } else {
      state = state.copyWith(
          search: state.search.setApiStatus(ApiStatus.ERROR,
              errorMessage: "No Shows to search"));
      log("No searched shows data to received");
    }
  }

  // SHOWS DETAIL
  Future<void> loadShowDetail(String id) async {
    if (state.showDetail.isLoading) return;

    // if (!forceRefresh && _isDataCached(ShowType.SHOWS)) return;

    state = state.copyWith(
        showDetail: state.showDetail.setApiStatus(ApiStatus.LOADING));

    log("Fetching shows detail data for id: $id");
    final showDetail = await ShowsServices.instance.fetchShowDetail(id);

    if (showDetail != null) {
      // _updateCache(ShowType.SHOWS);
      state = state.copyWith(
          showDetail: showDetail.setApiStatus(ApiStatus.SUCCESS,
              successMessage: "Shows Detail loaded successfully"));
      log("Shows Detail loaded successfully for id: $id");
    } else {
      state = state.copyWith(
          showDetail: state.showDetail.setApiStatus(ApiStatus.ERROR,
              errorMessage: "No Shows to fetch"));
      log("No showDetail data received for id: $id");
    }
  }

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
    for (int attempt = 1; attempt <= 3; attempt++) {
      collection = await ShowsServices.instance.fetchCollections();
      if (collection != null) {
        log("Collections fetched successfully on attempt $attempt");
        break;
      }
      log("Collections fetch attempt $attempt failed (null). Retrying...");
      await Future.delayed(Duration(seconds: 2 * attempt));
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

  // Update collection index to new screen
  void chooseTo(int index) {
    if (index < 0) {
      log("Invalid shows index: $index");
      return;
    }
    state = state.copyWith(showsIndex: index);
  }

  void readyToSearch(bool? value) {
    if (value == null) return;
    state = state.copyWith(searchValueExist: value);
    log("search -> ${state.searchValueExist}");
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
