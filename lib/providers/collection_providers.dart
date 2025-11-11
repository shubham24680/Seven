import 'package:seven/app/app.dart';

class CollectionState {
  ScrollController scrollController;
  bool isLoading;

  CollectionState({required this.scrollController, required this.isLoading});

  factory CollectionState.initial() =>
      CollectionState(scrollController: ScrollController(), isLoading: false);

  CollectionState copyWith({bool? isLoading}) => CollectionState(
      scrollController: scrollController,
      isLoading: isLoading ?? this.isLoading);
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
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onScroll() async {
    if (isBottom && !state.isLoading) {
      state = state.copyWith(isLoading: true);
      await ref.read(collectionProvider.notifier).loadMore();
      state = state.copyWith(isLoading: false);
    }
  }
}

final provider = StateNotifierProvider.autoDispose.family<CollectionNotifier,
        CollectionState, AsyncNotifierProvider<ShowNotifier, List<Result>>>(
    (ref, provider) => CollectionNotifier(ref, provider));
