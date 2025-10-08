import 'dart:developer';
import 'package:seven/app/app.dart';

class ProfileState {
  final int profilePicIndex;
  final String? name, email, phoneNumber, dateOfBirth;
  final TextEditingController nameController,
      emailController,
      phoneNumberController,
      dateOfBirthController;

  ProfileState(
      {required this.profilePicIndex,
      this.name,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      required this.nameController,
      required this.emailController,
      required this.phoneNumberController,
      required this.dateOfBirthController});

  factory ProfileState.initial() {
    return ProfileState(
        profilePicIndex: 0,
        nameController: TextEditingController(),
        emailController: TextEditingController(),
        phoneNumberController: TextEditingController(),
        dateOfBirthController: TextEditingController());
  }

  ProfileState copyWith(
      {int? profilePicIndex,
      String? name,
      String? email,
      String? phoneNumber,
      String? dateOfBirth}) {
    return ProfileState(
      profilePicIndex: profilePicIndex ?? this.profilePicIndex,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nameController: nameController,
      emailController: emailController,
      phoneNumberController: phoneNumberController,
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
        email: prefs.email);
  }

  void setIndexTo(int index) {
    state = state.copyWith(profilePicIndex: index);
    log("set index to ${state.profilePicIndex}");
  }

  Future<void> saveData() async {
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
