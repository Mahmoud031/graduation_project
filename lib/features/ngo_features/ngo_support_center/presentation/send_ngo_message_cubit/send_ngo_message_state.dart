part of 'send_ngo_message_cubit.dart';

@immutable
sealed class SendNgoMessageState {}

final class SendNgoMessageInitial extends SendNgoMessageState {}
final class SendNgoMessageLoading extends SendNgoMessageState {}
final class SendNgoMessageSuccess extends SendNgoMessageState {
}
final class SendNgoMessageFailure extends SendNgoMessageState {
  final String errMessage;

  SendNgoMessageFailure(this.errMessage);
}
