import 'dart:developer';

import 'package:seven/app/app.dart';

class ShowDetailState {
  final Result showDetail;
  final Result collectionDetail;

  const ShowDetailState(
      {required this.showDetail, required this.collectionDetail});

  factory ShowDetailState.initial() {
    return ShowDetailState(showDetail: Result(), collectionDetail: Result());
  }

  ShowDetailState copyWith({Result? showDetail, Result? collectionDetail}) {
    return ShowDetailState(
        showDetail: showDetail ?? this.showDetail,
        collectionDetail: collectionDetail ?? this.collectionDetail);
  }
}

class ShowDetailProvider extends StateNotifier<ShowDetailState> {
  final String showId;
  ShowDetailProvider(this.showId) : super(ShowDetailState.initial()) {
    _loadShowDetail(showId);
  }

  void refreshData() {
    _loadShowDetail(showId);
  }

  // SHOWS DETAIL
  Future<void> _loadShowDetail(String id) async {
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

  // COLLECTION DETAIL
  Future<void> loadCollectionDetail(String id) async {
    if (state.collectionDetail.isLoading) return;

    state = state.copyWith(
        collectionDetail:
            state.collectionDetail.setApiStatus(ApiStatus.LOADING));

    log("[loadCollectionDetail] Starting fetch for collection id: $id");
    final collectionDetail =
        await ShowsServices.instance.fetchCollectionDetail(id);

    if (collectionDetail != null) {
      state = state.copyWith(
          collectionDetail: collectionDetail.setApiStatus(ApiStatus.SUCCESS,
              successMessage: "Shows Detail loaded successfully"));
      log("[loadCollectionDetail] Successfully loaded collection detail for id: $id");
    } else {
      state = state.copyWith(
          collectionDetail: state.collectionDetail.setApiStatus(ApiStatus.ERROR,
              errorMessage: "No Shows to fetch"));
      log("[loadCollectionDetail] No collection detail found for id: $id");
    }
  }
}

final showDetailProvider = StateNotifierProvider.autoDispose
    .family<ShowDetailProvider, ShowDetailState, String>(
        (ref, showId) => ShowDetailProvider(showId));
