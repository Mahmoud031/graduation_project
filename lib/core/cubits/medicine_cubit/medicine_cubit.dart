import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:meta/meta.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit(this.medicineRepo) : super(MedicineInitial());
  final MedicineRepo medicineRepo;
  
  Future<void> getMedicine() async {
    emit(MedicineLoading());
    var result = await medicineRepo.getMedicine();
    result.fold(
      (failure) => emit(MedicineFailure(failure.message)),
      (medicines) => emit(MedicineSuccess(medicines)),
    );
  }

  Future<void> getMedicineByNgoUId(String ngoUId) async {
    emit(MedicineLoading());
    var result = await medicineRepo.getMedicineByNgoUId(ngoUId);
    result.fold(
      (failure) => emit(MedicineFailure(failure.message)),
      (medicines) => emit(MedicineSuccess(medicines)),
    );
  }
}
