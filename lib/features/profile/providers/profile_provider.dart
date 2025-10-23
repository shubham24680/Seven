import 'dart:developer';
import 'package:seven/app/app.dart';

class ProfileState {
  final int profilePicIndex, genderIndex;
  final bool tryEditing;
  final String? name, dateOfBirth;
  final TextEditingController nameController, dateOfBirthController;

  ProfileState(
      {required this.profilePicIndex,
      required this.tryEditing,
      this.name,
      required this.genderIndex,
      this.dateOfBirth,
      required this.nameController,
      required this.dateOfBirthController});

  factory ProfileState.initial() {
    return ProfileState(
        profilePicIndex: 0,
        tryEditing: false,
        genderIndex: -1,
        nameController: TextEditingController(),
        dateOfBirthController: TextEditingController());
  }

  ProfileState copyWith(
      {int? profilePicIndex,
      bool? tryEditing,
      String? name,
      int? genderIndex,
      String? dateOfBirth}) {
    return ProfileState(
      profilePicIndex: profilePicIndex ?? this.profilePicIndex,
      tryEditing: tryEditing ?? this.tryEditing,
      name: name ?? this.name,
      genderIndex: genderIndex ?? this.genderIndex,
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
      profilePicIndex: prefs.profilePicIndex,
      name: prefs.name,
      genderIndex: prefs.genderIndex,
      dateOfBirth: prefs.dateOfBirth,
      tryEditing: false,
    );
  }

  Future<void> saveData() async {
    state = state.copyWith(
        name: state.nameController.text,
        dateOfBirth: state.dateOfBirthController.text);

    final prefs = await SPD.getInstance();
    await prefs.setProfilePicIndex(state.profilePicIndex);
    await prefs.setGenderIndex(state.genderIndex);
    if (state.name != null) {
      await prefs.setName(state.name ?? "");
    }
    if (state.dateOfBirth != null) {
      await prefs.setDateOfBirth(state.dateOfBirth ?? "");
    }

    clearFromField();
    log("Saved succesfully at index ${state.profilePicIndex}");
  }

  void loadIntoField() {
    state.nameController.text = state.name ?? "";
    state.dateOfBirthController.text = state.dateOfBirth ?? "";
  }

  void clearFromField() {
    state.nameController.clear();
    state.dateOfBirthController.clear();
  }

  void toggle() {
    state = state.copyWith(tryEditing: !state.tryEditing);
    log("set editing to ${state.tryEditing}");
  }

  void setProfileIndexTo(int index) {
    state = state.copyWith(profilePicIndex: index);
    log("set index to ${state.profilePicIndex}");
  }

  void setGenderIndexTo(int index) {
    state = state.copyWith(genderIndex: index);
    log("set index to ${state.genderIndex}");
  }
}

final profileProvider = StateNotifierProvider<ProfileProvider, ProfileState>(
    (ref) => ProfileProvider());
