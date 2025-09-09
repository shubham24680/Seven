import 'dart:developer';
import 'package:seven/core/core.dart';

// MARK: Page State
class MovieState {
  final PageController pageController;
  final int currentIndex;

  MovieState({required this.pageController, required this.currentIndex});

  // State
  factory MovieState.initial() {
    return MovieState(
        pageController: PageController(initialPage: 0), currentIndex: 0);
  }

  // To Change Value
  MovieState copyWith({int? currentIndex}) {
    return MovieState(
        pageController: pageController,
        currentIndex: currentIndex ?? this.currentIndex);
  }
}

// MARK: Page Provider
class MovieProvider extends StateNotifier<MovieState> {
  MovieProvider() : super(MovieState.initial());

  // Update index when use controller
  void moveToPage(int index) {
    state = state.copyWith(currentIndex: index);
    log("INDEX -> ${state.currentIndex}");
  }

  // Move page using button
  void jumpToPage(int index) {
    state.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

final movieProvider = StateNotifierProvider<MovieProvider, MovieState>(
  (ref) => MovieProvider(),
);
