part of 'medicine_inventory_cubit.dart';

@immutable
sealed class MedicineInventoryState {}

final class MedicineInventoryInitial extends MedicineInventoryState {}
final class MedicineInventoryLoading extends MedicineInventoryState {}
final class MedicineInventorySuccess extends MedicineInventoryState {
  final List<MedicineInvnetoryEntity> medicines;

  MedicineInventorySuccess(this.medicines);
}
final class MedicineInventoryFailure extends MedicineInventoryState {
  final String message;
  MedicineInventoryFailure(this.message);
}
