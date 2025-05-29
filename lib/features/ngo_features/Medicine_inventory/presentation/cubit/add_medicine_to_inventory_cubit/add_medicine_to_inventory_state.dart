part of 'add_medicine_to_inventory_cubit.dart';

@immutable
sealed class AddMedicineToInventoryState {}

final class AddMedicineToInventoryInitial extends AddMedicineToInventoryState {}
final class AddMedicineToInventoryLoading extends AddMedicineToInventoryState {}
final class AddMedicineToInventorySuccess extends AddMedicineToInventoryState {
}
final class AddMedicineToInventoryFailure extends AddMedicineToInventoryState {
  final String errorMessage;

  AddMedicineToInventoryFailure(this.errorMessage);
}
