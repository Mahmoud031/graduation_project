import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'view_requests_state.dart';

class ViewRequestsCubit extends Cubit<ViewRequestsState> {
  final MedicineRequestRepo medicineRequestRepo;
  StreamSubscription? _subscription;

  ViewRequestsCubit(this.medicineRequestRepo) : super(ViewRequestsInitial());

  void listenToNgoRequests(String ngoUId) {
    emit(ViewRequestsLoading());
    _subscription?.cancel();
    _subscription = medicineRequestRepo.getMedicineRequestsByNgoUIdStream(ngoUId).listen(
      (requests) => emit(ViewRequestsSuccess(requests)),
      onError: (e) => emit(ViewRequestsFailure(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
} 