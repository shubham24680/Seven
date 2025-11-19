import 'package:seven/app/app.dart';

class CollectionState {
  ScrollController scrollController;
  bool isLoading;
  bool crossFadeState;

  CollectionState(
      {required this.scrollController,
      required this.isLoading,
      required this.crossFadeState});

  factory CollectionState.initial() => CollectionState(
      scrollController: ScrollController(),
      isLoading: false,
      crossFadeState: false);

  CollectionState copyWith({bool? isLoading, bool? crossFadeState}) =>
      CollectionState(
          scrollController: scrollController,
          isLoading: isLoading ?? this.isLoading,
          crossFadeState: crossFadeState ?? this.crossFadeState);
}

class CollectionNotifier extends StateNotifier<CollectionState> {
  final Ref ref;
  final AsyncNotifierProvider<ShowNotifier, List<Result>> collectionProvider;

  CollectionNotifier(this.ref, this.collectionProvider)
      : super(CollectionState.initial()) {
    state.scrollController.addListener(_onScroll);
  }

  bool get isBottom {
    if (!state.scrollController.hasClients) return false;

    final maxScroll = state.scrollController.position.maxScrollExtent;
    final currentScroll = state.scrollController.position.pixels;
    final crossFadeState = (currentScroll / maxScroll) >= 0.1;

    state = state.copyWith(crossFadeState: crossFadeState);
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onScroll() async {
    if (isBottom && !state.isLoading) {
      state = state.copyWith(isLoading: true);
      await ref.read(collectionProvider.notifier).loadMore();
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> animateToTop() async {
    final onTop = state.scrollController.position.minScrollExtent;
    state.scrollController.animateTo(onTop,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}

final provider = StateNotifierProvider.autoDispose.family<CollectionNotifier,
        CollectionState, AsyncNotifierProvider<ShowNotifier, List<Result>>>(
    (ref, provider) => CollectionNotifier(ref, provider));
