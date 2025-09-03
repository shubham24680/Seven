import 'dart:developer';
import 'package:seven/core/core.dart';

// MARK: Page State
class PageState {
  final PageController pageController;
  final int currentIndex;

  PageState({required this.pageController, required this.currentIndex});

  // State
  factory PageState.initial() {
    return PageState(
        pageController: PageController(initialPage: 0), currentIndex: 0);
  }

  // To Change Value
  PageState copyWith({int? currentIndex}) {
    return PageState(
        pageController: pageController,
        currentIndex: currentIndex ?? this.currentIndex);
  }
}

// MARK: Page Provider
class PageProvider extends StateNotifier<PageState> {
  PageProvider() : super(PageState.initial());

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

final pageProvider = StateNotifierProvider<PageProvider, PageState>(
  (ref) => PageProvider(),
);
