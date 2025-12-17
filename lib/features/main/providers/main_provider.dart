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
    final screens = await MainServices.instance.fetchMainScreenData();
    state = state.copyWith(screens: screens);
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
