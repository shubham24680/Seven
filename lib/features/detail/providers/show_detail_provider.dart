import 'dart:developer';

import 'package:seven/app/app.dart';

class ShowDetailState {
  final Result showDetail;

  const ShowDetailState({required this.showDetail});

  factory ShowDetailState.initial() {
    return ShowDetailState(showDetail: Result());
  }

  ShowDetailState copyWith({Result? showDetail}) {
    return ShowDetailState(showDetail: showDetail ?? this.showDetail);
  }
}

class ShowDetailProvider extends StateNotifier<ShowDetailState> {
  ShowDetailProvider() : super(ShowDetailState.initial());

  // SHOWS DETAIL
  Future<void> loadShowDetail(String id) async {
    if (state.showDetail.isLoading) return;

    state = state.copyWith(
        showDetail: state.showDetail.setApiStatus(ApiStatus.LOADING));

    log("Fetching shows detail data for id: $id");
    final showDetail = await ShowsServices.instance.fetchShowDetail(id);

    if (showDetail != null) {
      state = state.copyWith(
          showDetail: showDetail.setApiStatus(ApiStatus.SUCCESS,
              successMessage: "Shows Detail loaded successfully"));
      log("Shows Detail loaded successfully for id: $id");
    } else {
      state = state.copyWith(
          showDetail: state.showDetail.setApiStatus(ApiStatus.ERROR,
              errorMessage: "No Shows to fetch"));
      log("No showDetail data received for id: $id");
    }
  }
}

final showDetailProvider =
    StateNotifierProvider.autoDispose<ShowDetailProvider, ShowDetailState>(
        (ref) => ShowDetailProvider());
