part of 'ngo_profile_edit_cubit.dart';

abstract class NgoProfileEditState {}

class NgoProfileEditInitial extends NgoProfileEditState {}

class NgoProfileEditLoading extends NgoProfileEditState {}

class NgoProfileEditSuccess extends NgoProfileEditState {
  final NgoEntity updatedNgo;

  NgoProfileEditSuccess(this.updatedNgo);
}

class NgoProfileEditFailure extends NgoProfileEditState {
  final String error;
  NgoProfileEditFailure(this.error);
}
