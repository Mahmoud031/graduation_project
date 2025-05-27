part of 'medicine_cubit.dart';

@immutable
sealed class MedicineState {}

final class MedicineInitial extends MedicineState {}

final class MedicineLoading extends MedicineState {}

final class MedicineSuccess extends MedicineState {
  final List<MedicineEntity> medicines;

  MedicineSuccess(this.medicines);
}

final class MedicineFailure extends MedicineState {
  final String errorMessage;

  MedicineFailure(this.errorMessage);
}
