import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:meta/meta.dart';

part 'fulfill_request_state.dart';

class FulfillRequestCubit extends Cubit<FulfillRequestState> {
  final MedicineRequestRepo medicineRequestRepo;
  FulfillRequestCubit(this.medicineRequestRepo) : super(FulfillRequestInitial());

  Future<void> fulfillRequest(
    String requestId,
    String donorId,
    String donorName,
  ) async {
    emit(FulfillRequestLoading());
    final now = DateTime.now();
    final result = await medicineRequestRepo.updateMedicineRequestStatus(
      requestId,
      'Fulfilled',
      fulfilledDonorId: donorId,
      fulfilledDate: now.toIso8601String(),
      donorName: donorName,
    );
    result.fold(
      (failure) => emit(FulfillRequestFailure(failure.message)),
      (_) => emit(FulfillRequestSuccess()),
    );
  }
} 