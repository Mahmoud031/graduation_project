part of 'ngo_profile_cubit.dart';

abstract class NgoProfileState {}

class NgoProfileInitial extends NgoProfileState {}

class NgoProfileLoading extends NgoProfileState {}

class NgoProfileLoaded extends NgoProfileState {
  final NgoEntity ngo;
  NgoProfileLoaded(this.ngo);
}

class NgoProfileError extends NgoProfileState {
  final String message;
  NgoProfileError(this.message);
} 