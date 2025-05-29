import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:meta/meta.dart';

part 'add_medicine_to_inventory_state.dart';

class AddMedicineToInventoryCubit extends Cubit<AddMedicineToInventoryState> {
  AddMedicineToInventoryCubit(this.medicineInvnetoryRepo) : super(AddMedicineToInventoryInitial());
  final MedicineInvnetoryRepo medicineInvnetoryRepo;
  Future<void> addMedicineToInventory(MedicineInvnetoryEntity medicineInvnetoryEntity) async {
    emit(AddMedicineToInventoryLoading());
    var result = await medicineInvnetoryRepo.addMedicineInventory(medicineInvnetoryEntity);
    result.fold((failure) {
      emit(AddMedicineToInventoryFailure(failure.message));
    }, (success) {
      emit(AddMedicineToInventorySuccess());
    });
  }
}
