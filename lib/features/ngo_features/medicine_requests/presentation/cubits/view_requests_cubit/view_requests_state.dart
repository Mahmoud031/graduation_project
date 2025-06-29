part of 'view_requests_cubit.dart';

@immutable
abstract class ViewRequestsState {}

class ViewRequestsInitial extends ViewRequestsState {}
class ViewRequestsLoading extends ViewRequestsState {}
class ViewRequestsSuccess extends ViewRequestsState {
  final List<MedicineRequestEntity> requests;
  ViewRequestsSuccess(this.requests);
}
class ViewRequestsFailure extends ViewRequestsState {
  final String message;
  ViewRequestsFailure(this.message);
} 