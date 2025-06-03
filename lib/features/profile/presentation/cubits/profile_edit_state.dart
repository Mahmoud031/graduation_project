part of 'profile_edit_cubit.dart';

abstract class ProfileEditState {}

class ProfileEditInitial extends ProfileEditState {}
class ProfileEditLoading extends ProfileEditState {}
class ProfileEditSuccess extends ProfileEditState {
  final NgoEntity updatedNgo;

  ProfileEditSuccess(this.updatedNgo);
}
class ProfileEditFailure extends ProfileEditState {
  final String error;
  ProfileEditFailure(this.error);
} 