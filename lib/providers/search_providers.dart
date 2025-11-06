import 'package:flutter/rendering.dart';
import 'package:seven/app/app.dart';

abstract class SearchNotifier extends AsyncNotifier<List<Result>> {
  int _currentPage = 1;
  bool _hasMorePages = true;
  String _title = "";
  Future<ShowsModel> searchData(int page, String query);

  @override
  Future<List<Result>> build() async {
    return [];
  }

  Future<void> search(String query) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        _currentPage = 1;
        _title = query;
        final response = await searchData(_currentPage, _title);
        final totalPages = response.totalPages?.toInt();
        if (totalPages != null) _hasMorePages = _currentPage < totalPages;
        return response.results ?? [];
      } on ApiException catch (_) {
        rethrow;
      }
    });
  }

  Future<void> loadMore() async {
    if (!_hasMorePages || state.isLoading) return;

    final currentShows = state.valueOrNull ?? [];
    state = await AsyncValue.guard(() async {
      try {
        _currentPage++;
        final response = await searchData(_currentPage, _title);
        final totalPages = response.totalPages?.toInt();
        if (totalPages != null) _hasMorePages = _currentPage < totalPages;
        return [...currentShows, ...response.results ?? []];
      } on ApiException catch (_) {
        _currentPage--;
        return currentShows;
      }
    });
  }
}

class SearchWithTitleNotifier extends SearchNotifier {
  @override
  Future<ShowsModel> searchData(int page, String query) {
    final service = ShowsServices.instance;
    return service.searchWithTitle(page: page, title: query);
  }
}

final searchWithTitle =
    AsyncNotifierProvider<SearchWithTitleNotifier, List<Result>>(
        () => SearchWithTitleNotifier());

class SearchState {
  TextEditingController searchController;
  ScrollController scrollController;
  bool crossFadeState;
  bool searchValueExist;
  bool isLoading;

  SearchState(
      {required this.searchController,
      required this.scrollController,
      required this.crossFadeState,
      required this.searchValueExist,
      required this.isLoading});

  factory SearchState.initial() => SearchState(
      searchController: TextEditingController(),
      scrollController: ScrollController(),
      crossFadeState: false,
      searchValueExist: false,
      isLoading: false);

  SearchState copyWith(
          {bool? crossFadeState, bool? searchValueExist, bool? isLoading}) =>
      SearchState(
          searchController: searchController,
          scrollController: scrollController,
          crossFadeState: crossFadeState ?? this.crossFadeState,
          searchValueExist: searchValueExist ?? this.searchValueExist,
          isLoading: isLoading ?? this.isLoading);
}

class SearchProvider extends StateNotifier<SearchState> {
  final Ref ref;
  final AsyncNotifierProvider<SearchNotifier, List<Result>> searchProvider;

  SearchProvider(this.ref, this.searchProvider) : super(SearchState.initial()) {
    state.scrollController.addListener(_onScroll);
  }

  void readyToSearch(bool? value) {
    if (value == null) return;

    state = state.copyWith(searchValueExist: value);
  }

  bool get isBottom {
    if (!state.scrollController.hasClients) return false;

    final position = state.scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    final crossFadeState =
        position.userScrollDirection == ScrollDirection.reverse;

    state = state.copyWith(crossFadeState: crossFadeState);
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onScroll() async {
    if (isBottom && !state.isLoading) {
      state = state.copyWith(isLoading: true);
      await ref.read(searchProvider.notifier).loadMore();
      state = state.copyWith(isLoading: false);
    }
  }
}

final searchProvider = StateNotifierProvider.family<SearchProvider, SearchState,
        AsyncNotifierProvider<SearchNotifier, List<Result>>>(
    (ref, provider) => SearchProvider(ref, provider));
