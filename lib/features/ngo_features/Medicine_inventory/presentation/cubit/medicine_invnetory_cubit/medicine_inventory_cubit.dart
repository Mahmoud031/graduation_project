import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import '../../../domain/entities/medicine_invnetory_entity.dart';

part 'medicine_inventory_state.dart';

class MedicineInventoryCubit extends Cubit<MedicineInventoryState> {
  MedicineInventoryCubit(this.medicineInvnetoryRepo) : super(MedicineInventoryInitial());
  final MedicineInvnetoryRepo medicineInvnetoryRepo;
  StreamSubscription? _inventorySubscription;

  Future<void> getMedicineInventory() async {
    emit(MedicineInventoryLoading());
    var result = await medicineInvnetoryRepo.getMedicineInventory();
    result.fold(
      (failure) => emit(MedicineInventoryFailure(failure.message)),
      (medicines) => emit(MedicineInventorySuccess(medicines)),
    );
  }

  void listenToNgoInventory(String ngoUId) {
    _inventorySubscription?.cancel();
    emit(MedicineInventoryLoading());
    _inventorySubscription = medicineInvnetoryRepo
        .getMedicineInventoryByNgoUIdStream(ngoUId)
        .listen(
          (medicines) => emit(MedicineInventorySuccess(medicines)),
          onError: (e) => emit(MedicineInventoryFailure(e.toString())),
        );
  }

  @override
  Future<void> close() {
    _inventorySubscription?.cancel();
    return super.close();
  }

  Future<void> deleteMedicineInventory(String medicineId) async {
    emit(MedicineInventoryLoading());
    var result = await medicineInvnetoryRepo.deleteMedicineInventory(medicineId);
    result.fold(
      (failure) => emit(MedicineInventoryFailure(failure.message)),
      (_) => getMedicineInventory(),
    );
  }

  Future<void> updateMedicineInventory(MedicineInvnetoryEntity medicine) async {
    emit(MedicineInventoryLoading());
    var result = await medicineInvnetoryRepo.updateMedicineInventory(medicine);
    result.fold(
      (failure) => emit(MedicineInventoryFailure(failure.message)),
      (_) => getMedicineInventory(),
    );
  }
}
