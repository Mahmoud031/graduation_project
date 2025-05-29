import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit(this.medicineRepo) : super(MedicineInitial());
  final MedicineRepo medicineRepo;
  String? _currentNgoUId;
  StreamSubscription? _medicineSubscription;
  StreamSubscription? _donorMedicineSubscription;

  Future<void> getMedicine() async {
    emit(MedicineLoading());
    var result = await medicineRepo.getMedicine();
    result.fold(
      (failure) => emit(MedicineFailure(failure.message)),
      (medicines) => emit(MedicineSuccess(medicines)),
    );
  }

  void listenToNgoMedicines(String ngoUId) {
    _currentNgoUId = ngoUId;
    _medicineSubscription?.cancel();
    emit(MedicineLoading());
    _medicineSubscription =
        medicineRepo.getMedicineByNgoUIdStream(ngoUId).listen(
              (medicines) => emit(MedicineSuccess(medicines)),
              onError: (e) => emit(MedicineFailure(e.toString())),
            );
  }

  void listenToDonorMedicines(String userId) {
    _donorMedicineSubscription?.cancel();
    emit(MedicineLoading());
    _donorMedicineSubscription =
        medicineRepo.getMedicineByUserIdStream(userId).listen(
              (medicines) => emit(MedicineSuccess(medicines)),
              onError: (e) => emit(MedicineFailure(e.toString())),
            );
  }

  Future<void> updateMedicineStatus(String medicineId, String status) async {
    // emit(MedicineLoading()); // Removed to prevent loading state lock
    var result = await medicineRepo.updateMedicineStatus(medicineId, status);
    result.fold(
      (failure) => emit(MedicineFailure(failure.message)),
      (_) {
        // No need to manually refetch, stream will update UI
      },
    );
  }

  @override
  Future<void> close() {
    _medicineSubscription?.cancel();
    _donorMedicineSubscription?.cancel();
    return super.close();
  }
}
