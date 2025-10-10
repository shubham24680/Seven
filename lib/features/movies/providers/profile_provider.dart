import 'dart:developer';
import 'package:seven/app/app.dart';

class ProfileState {
  final int profilePicIndex;
  final bool tryEditing;
  final String? name, gender, dateOfBirth;
  final TextEditingController nameController, dateOfBirthController;

  ProfileState(
      {required this.profilePicIndex,
      required this.tryEditing,
      this.name,
      this.gender,
      this.dateOfBirth,
      required this.nameController,
      required this.dateOfBirthController});

  factory ProfileState.initial() {
    return ProfileState(
        profilePicIndex: 0,
        tryEditing: false,
        nameController: TextEditingController(),
        dateOfBirthController: TextEditingController());
  }

  ProfileState copyWith(
      {int? profilePicIndex,
      bool? tryEditing,
      String? name,
      String? gender,
      String? dateOfBirth}) {
    return ProfileState(
      profilePicIndex: profilePicIndex ?? this.profilePicIndex,
      tryEditing: tryEditing ?? this.tryEditing,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nameController: nameController,
      dateOfBirthController: dateOfBirthController,
    );
  }
}

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileState.initial()) {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SPD.getInstance();
    state = state.copyWith(
        profilePicIndex: prefs.profilePicIndex, name: prefs.name);
  }

  Future<void> saveData() async {
    state = state.copyWith(name: state.nameController.text);

    final prefs = await SPD.getInstance();
    await prefs.setProfilePicIndex(state.profilePicIndex);
    if (state.name != null) {
      await prefs.setName(state.name ?? "");
    }

    clearFromField();
    log("Saved succesfully at index ${state.profilePicIndex}");
  }

  void loadIntoField() {
    state.nameController.text = state.name ?? "";
  }

  void clearFromField() {
    state.nameController.clear();
  }

  void setIndexTo(int index) {
    state = state.copyWith(profilePicIndex: index);
    log("set index to ${state.profilePicIndex}");
  }

  void toggle() {
    state = state.copyWith(tryEditing: !state.tryEditing);
    log("set editing to ${state.tryEditing}");
  }
}

final profileProvider = StateNotifierProvider<ProfileProvider, ProfileState>(
    (ref) => ProfileProvider());
