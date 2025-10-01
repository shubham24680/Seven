import 'dart:developer';
import 'package:seven/app/app.dart';

class ProfileState {
  final int profilePicIndex;
  final String? name;
  final String? email;

  ProfileState({required this.profilePicIndex, this.name, this.email});

  factory ProfileState.initial() {
    return ProfileState(profilePicIndex: 0);
  }

  ProfileState copyWith({int? profilePicIndex, String? name, String? email}) {
    return ProfileState(
        profilePicIndex: profilePicIndex ?? this.profilePicIndex,
        name: name ?? this.name,
        email: email ?? this.email);
  }
}

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileState.initial()) {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SPD.getInstance();
    state = state.copyWith(
        profilePicIndex: prefs.profilePicIndex,
        name: prefs.name,
        email: prefs.email);
  }

  void setIndexTo(int index) {
    state = state.copyWith(profilePicIndex: index);
    log("set index to ${state.profilePicIndex}");
  }

  Future<void> save() async {
    final prefs = await SPD.getInstance();
    await prefs.setProfilePicIndex(state.profilePicIndex);
    if (state.name != null) {
      await prefs.setName(state.name ?? "");
    }
    if (state.email != null) {
      await prefs.setEmail(state.email ?? "");
    }
    log("Saved succesfully at index ${state.profilePicIndex}");
  }
}

final profileProvider = StateNotifierProvider<ProfileProvider, ProfileState>(
    (ref) => ProfileProvider());
