import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/repositories/medicine_invnetory_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/medicine_invnetory_entity.dart';

part 'medicine_inventory_state.dart';

class MedicineInventoryCubit extends Cubit<MedicineInventoryState> {
  MedicineInventoryCubit(this.medicineInvnetoryRepo) : super(MedicineInventoryInitial());
  final MedicineInvnetoryRepo medicineInvnetoryRepo;
  Future<void> getMedicineInventory() async {
    emit(MedicineInventoryLoading());
    var result = await medicineInvnetoryRepo.getMedicineInventory();
    result.fold(
      (failure) => emit(MedicineInventoryFailure(failure.message)),
      (medicines) => emit(MedicineInventorySuccess(medicines)),
    );
  }
}
