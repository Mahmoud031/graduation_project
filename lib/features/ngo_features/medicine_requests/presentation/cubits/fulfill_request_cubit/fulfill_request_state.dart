part of 'fulfill_request_cubit.dart';

@immutable
abstract class FulfillRequestState {}

class FulfillRequestInitial extends FulfillRequestState {}
class FulfillRequestLoading extends FulfillRequestState {}
class FulfillRequestSuccess extends FulfillRequestState {}
class FulfillRequestFailure extends FulfillRequestState {
  final String message;
  FulfillRequestFailure(this.message);
} 