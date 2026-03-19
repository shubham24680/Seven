import 'package:seven/app/app.dart';

class CricketState {
  final List<Item>? matches;
  final Map<String, Color> colors;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  CricketState({
    this.matches = const [],
    this.colors = const {},
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = "",
  });

  CricketState copyWith({
    List<Item>? matches,
    Map<String, Color>? colors,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return CricketState(
      matches: matches ?? this.matches,
      colors: colors ?? this.colors,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CricketNotifier extends StateNotifier<CricketState> {
  CricketNotifier() : super(CricketState()) {
    fetchLiveMatches();
  }

  Future<void> fetchLiveMatches() async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await SportsServices.instance.fetchLiveMatches();
      final items = data.response?.items;
      final colors = <String, Color>{};
      if (items != null) {
        for (var item in items) {
          final firstTeamLogo = item.teama?.logoUrl;
          final secondTeamLogo = item.teamb?.logoUrl;
          if (firstTeamLogo != null) {
            colors[firstTeamLogo] =
                await PaletteGenerator.extractColor(firstTeamLogo);
          }
          if (secondTeamLogo != null) {
            colors[secondTeamLogo] =
                await PaletteGenerator.extractColor(secondTeamLogo);
          }
        }
      }
      state = state.copyWith(matches: items, colors: colors, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isError: true, errorMessage: e.toString(), isLoading: false);
    }
  }
}

final cricketLiveProvider =
    StateNotifierProvider<CricketNotifier, CricketState>(
        (ref) => CricketNotifier());
