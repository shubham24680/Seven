import 'package:flutter/rendering.dart';
import 'package:seven/core/packages/app_packages.dart';

final navigationProvider = StateProvider.autoDispose<int>((ref) => 0);

class HomeState {
  final ScrollController scrollController;
  final bool crossFadeState;

  HomeState({required this.scrollController, required this.crossFadeState});

  factory HomeState.initial() =>
      HomeState(scrollController: ScrollController(), crossFadeState: false);

  HomeState copyWith({bool? crossFadeState}) => HomeState(
      scrollController: scrollController,
      crossFadeState: crossFadeState ?? this.crossFadeState);
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState.initial()) {
    state.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final crossFadeState =
        state.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse;
    state = state.copyWith(crossFadeState: crossFadeState);
  }
}

final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier());
