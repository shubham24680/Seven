import 'package:seven/app/app.dart';

abstract class SearchNotifier extends AutoDisposeAsyncNotifier<List<Result>?> {
  int _currentPage = 1;
  bool _hasMorePages = true;
  String _title = "";
  List<Result>? _filterResponse;
  Future<ShowsModel> searchData(int page, String query);

  @override
  List<Result>? build() => null;

  Future<void> search(String query, List<int> filter) async {
    query = query.trim().toLowerCase();
    if (query == _title && !state.hasError) return;

    state = AsyncValue.loading();
    try {
      _currentPage = 1;
      _title = query;
      final response = await searchData(_currentPage, _title);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;
      _filterResponse = response.results ?? [];
      applyFilter(filter);
    } on ApiException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadMore(List<int> filter) async {
    if (!_hasMorePages || state.isLoading) return;

    try {
      _currentPage++;
      final response = await searchData(_currentPage, _title);
      final totalPages = response.totalPages?.toInt();
      if (totalPages != null) _hasMorePages = _currentPage < totalPages;
      _filterResponse = [..._filterResponse ?? [], ...response.results ?? []];
    } on ApiException catch (_) {
      _currentPage--;
    } finally {
      applyFilter(filter);
    }
  }

  Future<void> applyFilter(List<int> filterId) async {
    state = await AsyncValue.guard(() async {
      try {
        if (_filterResponse == null || filterId.isEmpty) return _filterResponse;

        final filteredShows = _filterResponse?.where((show) {
          final showGenre = show.genreIds ?? [];
          return showGenre.any((gen) => filterId.contains(gen));
        }).toList();

        return filteredShows;
      } on ApiException catch (_) {
        return _filterResponse;
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
    AutoDisposeAsyncNotifierProvider<SearchWithTitleNotifier, List<Result>?>(
        () => SearchWithTitleNotifier());

class SearchState {
  TextEditingController searchController;
  ScrollController scrollController;
  List<int> selectedGrenre;
  bool crossFadeState;
  bool searchValueExist;
  bool isLoading;

  SearchState(
      {required this.searchController,
      required this.scrollController,
      required this.selectedGrenre,
      required this.crossFadeState,
      required this.searchValueExist,
      required this.isLoading});

  factory SearchState.initial() => SearchState(
      searchController: TextEditingController(),
      scrollController: ScrollController(),
      selectedGrenre: [],
      crossFadeState: false,
      searchValueExist: false,
      isLoading: false);

  SearchState copyWith(
          {List<int>? selectedGrenre,
          bool? crossFadeState,
          bool? searchValueExist,
          bool? isLoading}) =>
      SearchState(
          searchController: searchController,
          scrollController: scrollController,
          selectedGrenre: selectedGrenre ?? this.selectedGrenre,
          crossFadeState: crossFadeState ?? this.crossFadeState,
          searchValueExist: searchValueExist ?? this.searchValueExist,
          isLoading: isLoading ?? this.isLoading);
}

class SearchProvider extends StateNotifier<SearchState> {
  final Ref ref;
  final AutoDisposeAsyncNotifierProvider<SearchNotifier, List<Result>?>
      searchProvider;

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
    final crossFadeState = (currentScroll / maxScroll) >= 0.1;

    state = state.copyWith(crossFadeState: crossFadeState);
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onScroll() async {
    if (isBottom && !state.isLoading) {
      state = state.copyWith(isLoading: true);
      await ref.read(searchProvider.notifier).loadMore(state.selectedGrenre);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> animateToTop() async {
    final onTop = state.scrollController.position.minScrollExtent;
    state.scrollController.animateTo(onTop,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<void> addChoice(int id) async {
    state = state.copyWith(selectedGrenre: [...state.selectedGrenre, id]);
    _searchGenres();
  }

  Future<void> removeChoice(int id) async {
    final tempList = state.selectedGrenre.where((x) => x != id).toList();
    state = state.copyWith(selectedGrenre: tempList);
    _searchGenres();
  }

  Future<void> _searchGenres() async {
    await ref.read(searchProvider.notifier).applyFilter(state.selectedGrenre);
  }
}

final searchProvider = StateNotifierProvider.autoDispose.family<
        SearchProvider,
        SearchState,
        AutoDisposeAsyncNotifierProvider<SearchNotifier, List<Result>?>>(
    (ref, provider) => SearchProvider(ref, provider));
