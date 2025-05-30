import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';

MedicineInvnetoryEntity getDummyMedicineInventory() {
  return MedicineInvnetoryEntity(
    medicineName: 'Aspirin',
    id: '43eX6no7yndodn565OkKdXfRLAo1',
    category: 'Pain Relief',
    quantityAvailable: '100',
    recievedDate: '21/4/2023',
    prurchasedDate: '21/4/2023',
    expiryDate: '21/4/2023',
    status: 'opened',
    donorInfo: 'mahmoud rady',
    physicalCondition: 'good condition', 
    notes: 'No special notes',
  );

}
List<MedicineInvnetoryEntity> getDummyMedicineInventoryList() {
  return [
    getDummyMedicineInventory(),
    getDummyMedicineInventory(),
    getDummyMedicineInventory(),
    getDummyMedicineInventory(),
    getDummyMedicineInventory(),
  ];
}