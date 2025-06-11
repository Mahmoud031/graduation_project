part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}
final class SigninSuccess extends SigninState {
  final dynamic entity; // Can be either UserEntity or NgoEntity
  final bool isGoogleSignIn;
  SigninSuccess(this.entity, {this.isGoogleSignIn = false});
}
final class SigninFailure extends SigninState {
  final String message;
  SigninFailure({required this.message});
}