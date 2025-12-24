import 'dart:developer';
import '../../../app/app.dart';

class MainState {
  final MainModel screens;
  final int navigationCurrentIndex;

  MainState({required this.screens, required this.navigationCurrentIndex});

  factory MainState.initial() =>
      MainState(screens: MainModel(), navigationCurrentIndex: 0);

  MainState copyWith({MainModel? screens, int? navigationCurrentIndex}) =>
      MainState(
          screens: screens ?? this.screens,
          navigationCurrentIndex:
              navigationCurrentIndex ?? this.navigationCurrentIndex);
}

class MainProvider extends StateNotifier<MainState> {
  MainProvider() : super(MainState.initial()) {
    _loadData();
  }

  Future<void> _loadData() async {
    final storage = await SPD.getInstance();
    try {
      final cache = storage.getCache(StorageConstants.SCREENS);
      log("CACHE - $cache");
      if (cache != null) {
        log("Loaded screens from storage");
        state = state.copyWith(screens: MainModel.fromJson(cache));
      }

      final screens = await MainServices.instance.fetchMainScreenData();
      state = state.copyWith(screens: screens);

      final check =
          await storage.setCache(StorageConstants.SCREENS, screens.toJson());
      log("CHECK - $check");
    } on ApiException catch (e) {
      log(" [MainProvider] Exception -> $e");
    }
  }

  // Update navigation index with validation
  void moveToPage(int index) {
    if (index < 0) {
      log("Invalid navigation index: $index");
      return;
    }
    state = state.copyWith(navigationCurrentIndex: index);
    log("Navigation index updated: $index");
  }
}

final mainProvider =
    StateNotifierProvider<MainProvider, MainState>((ref) => MainProvider());
