part of 'donor_profile_edit_cubit.dart';

abstract class DonorProfileEditState {}

class DonorProfileEditInitial extends DonorProfileEditState {}

class DonorProfileEditLoading extends DonorProfileEditState {}

class DonorProfileEditSuccess extends DonorProfileEditState {
  final UserEntity updatedUser;

  DonorProfileEditSuccess(this.updatedUser);
}

class DonorProfileEditFailure extends DonorProfileEditState {
  final String error;

  DonorProfileEditFailure(this.error);
} 