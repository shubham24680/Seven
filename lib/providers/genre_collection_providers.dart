import 'package:seven/app/app.dart';

abstract class GenreNotifier extends FamilyAsyncNotifier<List<Result>, String> {
  int _currentPage = 1;
  bool _hasMorePages = false;

  Future<ShowsModel> loadGenreCollection(int page, String genreId);

  @override
  Future<List<Result>> build(String arg) async {
    try {
      final response = await loadGenreCollection(_currentPage, arg);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;
      return response.results ?? [];
    } on ApiException catch (_) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return build(arg);
    });
  }

  Future<void> loadMore() async {
    if (!_hasMorePages || state.isLoading) return;

    final currentValue = state.valueOrNull ?? [];
    state = await AsyncValue.guard(() async {
      try {
        _currentPage++;
        final response = await loadGenreCollection(_currentPage, arg);
        final totalPages = response.totalPages?.toInt();
        if (totalPages != null) _hasMorePages = _currentPage < totalPages;
        return [...currentValue, ...response.results ?? []];
      } on ApiException catch (_) {
        _currentPage--;
        return currentValue;
      }
    });
  }
}

class GenreCollectionNotifier extends GenreNotifier {
  @override
  Future<ShowsModel> loadGenreCollection(int page, String genreId) async {
    final service = ShowsServices.instance;
    return service.fetchGenreCollection(page: page, genreId: genreId);
  }
}

final genreCollectionProvider =
    AsyncNotifierProviderFamily<GenreCollectionNotifier, List<Result>, String>(
        () => GenreCollectionNotifier());

class GenreState {
  ScrollController scrollController;
  bool isLoading;

  GenreState({required this.scrollController, required this.isLoading});

  factory GenreState.initial() =>
      GenreState(scrollController: ScrollController(), isLoading: false);

  GenreState copyWith({bool? isLoading}) => GenreState(
      scrollController: scrollController,
      isLoading: isLoading ?? this.isLoading);
}

class GenreCollectionProvider extends StateNotifier<GenreState> {
  final Ref ref;
  final AsyncNotifierFamilyProvider<GenreNotifier, List<Result>, String>
      collectionProvider;

  GenreCollectionProvider(this.ref, this.collectionProvider)
      : super(GenreState.initial()) {
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

final genreProvider = StateNotifierProvider.autoDispose.family<
    GenreCollectionProvider,
    GenreState,
    AsyncNotifierFamilyProvider<GenreCollectionNotifier, List<Result>, String>>(
  (ref, provider) => GenreCollectionProvider(ref, provider),
);
