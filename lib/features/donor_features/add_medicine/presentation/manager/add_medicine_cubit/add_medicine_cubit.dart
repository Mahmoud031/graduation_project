import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/images_repo.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/repos/medicine_repo.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:meta/meta.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
part 'add_medicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  AddMedicineCubit(this.imagesRepo, this.medicineRepo)
      : super(AddMedicineInitial());
  final ImagesRepo imagesRepo;
  final MedicineRepo medicineRepo;
  Future<void> addMedicine(MedicineEntity addNewMedicineEntity, {String? requestId}) async {
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
      }, (r) async {
        if (requestId != null) {
          final repo = GetIt.I<MedicineRequestRepo>();
          final user = getUser();
          // Fetch the request
          final allRequests = await repo.getAllMedicineRequests();
          allRequests.fold((_) {}, (requests) async {
            MedicineRequestEntity? req;
            try {
              req = requests.firstWhere((e) => e.id == requestId);
            } catch (_) {
              req = null;
            }
            if (req != null) {
              // Check medicine name match (case-insensitive, trimmed)
              if (req.medicineName.trim().toLowerCase() == addNewMedicineEntity.medicineName.trim().toLowerCase()) {
                final int reqQty = int.tryParse(req.quantity) ?? 0;
                final int prevFulfilled = int.tryParse(req.fulfilledQuantity) ?? 0;
                final int donatedQty = int.tryParse(addNewMedicineEntity.tabletCount) ?? 0;
                print('Current fulfilledQuantity: ${req.fulfilledQuantity}');
                print('Donated tabletCount: ${addNewMedicineEntity.tabletCount}');
                final int newFulfilled = prevFulfilled + donatedQty;
                print('New fulfilledQuantity: $newFulfilled');
                final bool isFulfilled = newFulfilled >= reqQty;
                // Add donation record to donations array
                final newDonation = {
                  'donorId': user.uId,
                  'donorName': user.name,
                  'quantity': addNewMedicineEntity.tabletCount,
                  'date': DateTime.now().toIso8601String(),
                };
                final updatedDonations = List<Map<String, dynamic>>.from(req.donations)..add(newDonation);
                await repo.updateMedicineRequestStatus(
                  requestId,
                  isFulfilled ? 'Fulfilled' : 'Active',
                  fulfilledDonorId: user.uId,
                  donorName: user.name,
                  fulfilledDate: DateTime.now().toIso8601String(),
                  fulfilledQuantity: newFulfilled.toString(),
                  donations: updatedDonations,
                );
              }
            }
          });
        }
        emit(AddMedicineSuccess());
      });
    });
  }
}
