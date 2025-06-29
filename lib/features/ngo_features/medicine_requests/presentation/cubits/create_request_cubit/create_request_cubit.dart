import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:meta/meta.dart';

part 'create_request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  final MedicineRequestRepo medicineRequestRepo;
  CreateRequestCubit(this.medicineRequestRepo) : super(CreateRequestInitial());

  Future<void> createRequest(MedicineRequestEntity request) async {
    emit(CreateRequestLoading());
    final result = await medicineRequestRepo.createMedicineRequest(request);
    result.fold(
      (failure) => emit(CreateRequestFailure(failure.message)),
      (_) => emit(CreateRequestSuccess()),
    );
  }
} 