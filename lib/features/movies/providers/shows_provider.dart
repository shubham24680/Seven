import 'dart:developer';
import 'package:seven/app/app.dart';

class ShowsState {
  final ShowsModel shows;
  final GenreModel genre;
  final Network status;
  final int currentIndex;

  ShowsState(
      {required this.shows,
      required this.genre,
      // required this.nowPlaying,
      // required this.popular,
      // required this.topRated,
      // required this.upcoming,
      required this.status,
      required this.currentIndex});

  factory ShowsState.initial() {
    return ShowsState(
        shows: ShowsModel(),
        genre: GenreModel(),
        // nowPlaying: ShowsModel(),
        // popular: ShowsModel(),
        // topRated: ShowsModel(),
        // upcoming: ShowsModel(),
        status: Network(),
        currentIndex: 0);
  }

  // To Change Value
  ShowsState copyWith(
      {ShowsModel? shows,
      GenreModel? genre,
      // ShowsModel? nowPlaying,
      // ShowsModel? popular,
      // ShowsModel? topRated,
      // ShowsModel? upcoming,
      Network? status,
      int? currentIndex}) {
    return ShowsState(
        shows: shows ?? this.shows,
        genre: genre ?? this.genre,
        // nowPlaying: nowPlaying ?? this.nowPlaying,
        // popular: popular ?? this.popular,
        // topRated: topRated ?? this.topRated,
        // upcoming: upcoming ?? this.upcoming,
        status: status ?? this.status,
        currentIndex: currentIndex ?? this.currentIndex);
  }
}

class ShowsProvider extends StateNotifier<ShowsState> {
  ShowsProvider() : super(ShowsState.initial());

  Future<void> loadShows() async {
    if (state.status.isLoading) return;
    state = state.copyWith(
      status: Network(apiStatus: ApiStatus.LOADING),
    );

    try {
      log("fetch Shows");
      final shows = await ShowsServices.instance.fetchShows();
      final genre = await ShowsServices.instance.fetchGenres();

      if (shows.results != null) {
        state = state.copyWith(
          shows: shows,
          genre: genre,
          status: Network(
            apiStatus: ApiStatus.SUCCESS,
            successMessage: "Shows loaded successfully",
          ),
        );
      } else {
        state = state.copyWith(
            status:
                Network(apiStatus: ApiStatus.EMPTY, errorMessage: "No Shows"));
      }
    } on ApiException catch (e) {
      state = state.copyWith(
          status:
              Network(apiStatus: ApiStatus.ERROR, errorMessage: e.toString()));
    } catch (e) {
      state = state.copyWith(
        status: Network(
          apiStatus: ApiStatus.ERROR,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // // Load Now Playing movies
  // Future<void> loadNowPlaying() async {
  //   if (state.status.isLoading) return;
  //   state = state.copyWith(
  //     status: Network(apiStatus: ApiStatus.LOADING),
  //   );

  //   try {
  //     log("fetch Now Playing");
  //     final nowPlaying = await ShowsServices.instance.fetchNowPlaying();

  //     if (nowPlaying.results != null) {
  //       state = state.copyWith(
  //         nowPlaying: nowPlaying,
  //         status: Network(
  //           apiStatus: ApiStatus.SUCCESS,
  //           successMessage: "Now Playing loaded successfully",
  //         ),
  //       );
  //     } else {
  //       state = state.copyWith(
  //           status: Network(
  //               apiStatus: ApiStatus.EMPTY,
  //               errorMessage: "No Now Playing movies"));
  //     }
  //   } on ApiException catch (e) {
  //     state = state.copyWith(
  //         status:
  //             Network(apiStatus: ApiStatus.ERROR, errorMessage: e.toString()));
  //   } catch (e) {
  //     state = state.copyWith(
  //       status: Network(
  //         apiStatus: ApiStatus.ERROR,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // // Load Popular movies
  // Future<void> loadPopular() async {
  //   if (state.status.isLoading) return;
  //   state = state.copyWith(
  //     status: Network(apiStatus: ApiStatus.LOADING),
  //   );

  //   try {
  //     log("fetch Popular");
  //     final popular = await ShowsServices.instance.fetchPopular();

  //     if (popular.results != null) {
  //       state = state.copyWith(
  //         popular: popular,
  //         status: Network(
  //           apiStatus: ApiStatus.SUCCESS,
  //           successMessage: "Popular loaded successfully",
  //         ),
  //       );
  //     } else {
  //       state = state.copyWith(
  //           status: Network(
  //               apiStatus: ApiStatus.EMPTY, errorMessage: "No Popular movies"));
  //     }
  //   } on ApiException catch (e) {
  //     state = state.copyWith(
  //         status:
  //             Network(apiStatus: ApiStatus.ERROR, errorMessage: e.toString()));
  //   } catch (e) {
  //     state = state.copyWith(
  //       status: Network(
  //         apiStatus: ApiStatus.ERROR,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // // Load Top Rated movies
  // Future<void> loadTopRated() async {
  //   if (state.status.isLoading) return;
  //   state = state.copyWith(
  //     status: Network(apiStatus: ApiStatus.LOADING),
  //   );

  //   try {
  //     log("fetch Top Rated");
  //     final topRated = await ShowsServices.instance.fetchTopRated();

  //     if (topRated.results != null) {
  //       state = state.copyWith(
  //         topRated: topRated,
  //         status: Network(
  //           apiStatus: ApiStatus.SUCCESS,
  //           successMessage: "Top Rated loaded successfully",
  //         ),
  //       );
  //     } else {
  //       state = state.copyWith(
  //           status: Network(
  //               apiStatus: ApiStatus.EMPTY,
  //               errorMessage: "No Top Rated movies"));
  //     }
  //   } on ApiException catch (e) {
  //     state = state.copyWith(
  //         status:
  //             Network(apiStatus: ApiStatus.ERROR, errorMessage: e.toString()));
  //   } catch (e) {
  //     state = state.copyWith(
  //       status: Network(
  //         apiStatus: ApiStatus.ERROR,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // // Load Upcoming movies
  // Future<void> loadUpcoming() async {
  //   if (state.status.isLoading) return;
  //   state = state.copyWith(
  //     status: Network(apiStatus: ApiStatus.LOADING),
  //   );

  //   try {
  //     log("fetch Upcoming");
  //     final upcoming = await ShowsServices.instance.fetchUpcoming();

  //     if (upcoming.results != null) {
  //       state = state.copyWith(
  //         upcoming: upcoming,
  //         status: Network(
  //           apiStatus: ApiStatus.SUCCESS,
  //           successMessage: "Upcoming loaded successfully",
  //         ),
  //       );
  //     } else {
  //       state = state.copyWith(
  //           status: Network(
  //               apiStatus: ApiStatus.EMPTY,
  //               errorMessage: "No Upcoming movies"));
  //     }
  //   } on ApiException catch (e) {
  //     state = state.copyWith(
  //         status:
  //             Network(apiStatus: ApiStatus.ERROR, errorMessage: e.toString()));
  //   } catch (e) {
  //     state = state.copyWith(
  //       status: Network(
  //         apiStatus: ApiStatus.ERROR,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // // Load all categories at once
  // Future<void> loadAllCategories() async {
  //   await Future.wait([
  //     loadShows(),
  // loadNowPlaying(),
  // loadPopular(),
  // loadTopRated(),
  // loadUpcoming(),
  // ]);
  // }

  // Refresh the page
  void refresh() {
    log("Refresh - reloading shows");
    loadShows();
  }

  // Refresh all categories
  // void refreshAll() {
  //   log("Refresh - reloading all categories");
  //   loadAllCategories();
  // }

  // Update index when use controller
  void moveToPage(int index) {
    state = state.copyWith(currentIndex: index);
    log("INDEX -> ${state.currentIndex}");
  }
}

final showsProvider = StateNotifierProvider<ShowsProvider, ShowsState>(
  (ref) => ShowsProvider(),
);

final carouselCurrentIndex = StateProvider.autoDispose<int>((ref) => 0);
