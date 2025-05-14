import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/add_medicine/domain/entities/medicine_entity.dart';
import 'package:graduation_project/features/add_medicine/domain/repos/images_repo.dart';
import 'package:graduation_project/features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:meta/meta.dart';
part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit(this.imagesRepo, this.medicineRepo)
      : super(AddMedicineInitial());
  final ImagesRepo imagesRepo;
  final MedicineRepo medicineRepo;
  Future<void> addMedicine(MedicineEntity addNewMedicineEntity) async {
    emit(AddMedicineLoading());
    var result = await imagesRepo.uploadImage(addNewMedicineEntity.imageFile);
    result.fold((f) {
      emit(
        AddMedicineFailure(f.message),
      );
    }, (url) async {
      addNewMedicineEntity.imageUrl = url;
      var result = await medicineRepo.addMedicine(addNewMedicineEntity);
      result.fold((f) {
        emit(
          AddMedicineFailure(f.message),
        );
      }, (r) {
        emit(AddMedicineSuccess());
      });
    });
  }
}
