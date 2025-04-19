part of 'ngo_signup_cubit.dart';

@immutable
sealed class NgoSignupState {}

final class NgoSignupInitial extends NgoSignupState {}

final class NgoSignupLoading extends NgoSignupState {}
final class NgoSignupSuccess extends NgoSignupState {
  final NgoEntity ngoEntity;

  NgoSignupSuccess({required this.ngoEntity});
}
final class NgoSignupFailure extends NgoSignupState {
  final String message;

  NgoSignupFailure({required this.message});
}