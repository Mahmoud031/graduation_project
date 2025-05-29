import 'dart:io';

import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';

MedicineEntity getDummyMedicine() {
  return MedicineEntity(
    medicineName: 'Paracetamol',
    tabletCount: '20',
    details: 'Pain reliever and fever reducer',
    purchasedDate: '2023-10-01',
    expiryDate: '2025-10-01',
    imageUrl: null, // Replace with a valid file path
    ngoName: 'Health NGO',
    imageFile: File(''),
    userId: '43eX6no7yndodn565OkKdXfRLAo1',
    ngoUId: '43eX6no7yndodn565OkKdXfRLAo1', donorName: 'Mahmoud Rady',
    id: '43eX6no7yndodn565OkKdXfRLAo1', receivedDate: '2023-10-01',
  );
}

List<MedicineEntity> getDummyMedicineList() {
  return [
    getDummyMedicine(),
    getDummyMedicine(),
    getDummyMedicine(),
    getDummyMedicine(),
    getDummyMedicine(),
  ];
}
