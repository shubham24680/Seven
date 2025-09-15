import 'dart:developer';
import 'package:seven/app/app.dart';

class ShowsState {
  final ShowsModel shows;
  final Network status;
  final int currentIndex;

  ShowsState(
      {required this.shows, required this.status, required this.currentIndex});

  factory ShowsState.initial() {
    return ShowsState(shows: ShowsModel(), status: Network(), currentIndex: 0);
  }

  // To Change Value
  ShowsState copyWith({ShowsModel? shows, Network? status, int? currentIndex}) {
    return ShowsState(
        shows: shows ?? this.shows,
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
      final shows = await ShowsServices.instance.fetchShows();

      if (shows.results != null) {
        state = state.copyWith(
          shows: shows,
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

  // Update index when use controller
  void moveToPage(int index) {
    state = state.copyWith(currentIndex: index);
    log("INDEX -> ${state.currentIndex}");
  }
}

final showsProvider = StateNotifierProvider<ShowsProvider, ShowsState>(
  (ref) => ShowsProvider(),
);
