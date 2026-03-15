import 'package:seven/core/packages/app_packages.dart';

final bottomNavigationProvider = StateProvider<int>((ref) => 0);

class ScrollState {
  final ScrollController scrollController;
  final bool crossFadeState;

  ScrollState({required this.scrollController, required this.crossFadeState});

  factory ScrollState.initial() =>
      ScrollState(scrollController: ScrollController(), crossFadeState: false);

  ScrollState copyWith({bool? crossFadeState}) => ScrollState(
      scrollController: scrollController,
      crossFadeState: crossFadeState ?? this.crossFadeState);
}

class ScrollNotifier extends StateNotifier<ScrollState> {
  double _lastScroll = 0.0;
  double _totalScroll = 0.0;
  static const double _scrollThreshold = -200;

  ScrollNotifier() : super(ScrollState.initial()) {
    state.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if(!state.scrollController.hasClients) return;
    final position = state.scrollController.position;
    final pixels = position.pixels;
    final delta = pixels - _lastScroll;

    if (delta.abs() < 2) return;
    _totalScroll = (delta >= 0) ? 0 : _totalScroll + delta;

    if (_totalScroll <= _scrollThreshold) {
      state = state.copyWith(crossFadeState: false);
    } else if (_totalScroll >= 0) {
      state = state.copyWith(crossFadeState: true);
      _totalScroll = 0;
    }

    _lastScroll = pixels;
  }
}

final scrollProvider =
    StateNotifierProvider.family<ScrollNotifier, ScrollState, int>(
        (ref, index) => ScrollNotifier());
