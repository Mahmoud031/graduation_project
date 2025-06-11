import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/date_field_widget.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_form_fields.dart';

class AddMedicineDialogWidgets {
  static Widget buildDialogContent({
    required GlobalKey<FormState> formKey,
    required TextEditingController medicineNameController,
    required TextEditingController quantityController,
    required TextEditingController donorInfoController,
    required TextEditingController notesController,
    required DateTime? receivedDate,
    required DateTime? expiryDate,
    required DateTime? productionDate,
    required String? selectedCategory,
    required String? selectedStatus,
    required String? selectedCondition,
    required String? dateError,
    required List<String> categories,
    required List<String> statuses,
    required List<String> conditions,
    required Function(String?) onCategoryChanged,
    required Function(String?) onStatusChanged,
    required Function(String?) onConditionChanged,
    required Function() onReceivedDateTap,
    required Function() onExpiryDateTap,
    required Function() onProductionDateTap,
    required Function() onAddPressed,
    required Function(String?) onMedicineNameSaved,
    required Function(String?) onQuantitySaved,
    required Function(String?) onDonorInfoSaved,
    required Function(String?) onNotesSaved,
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add New Medicine',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MedicineTextField(
              labelText: 'Name',
              hintText: 'Medicine Name',
              prefixIcon: Icons.medication,
              controller: medicineNameController,
              onSaved: onMedicineNameSaved,
            ),
            const SizedBox(height: 16),
            MedicineFormFields.buildDropdown(
              label: 'Category',
              icon: Icons.category,
              items: categories,
              value: selectedCategory,
              onChanged: onCategoryChanged,
            ),
            const SizedBox(height: 16),
            MedicineTextField(
              labelText: 'Quantity',
              hintText: 'Quantity Available',
              prefixIcon: Icons.inventory_2,
              controller: quantityController,
              onSaved: onQuantitySaved,
            ),
            const SizedBox(height: 16),
            DateFieldWidget(
              labelText: 'Received Date',
              hintText: 'Received Date',
              icon: Icons.calendar_today,
              isPurchasedDate: true,
              selectedDate: receivedDate,
              onDateTap: onReceivedDateTap,
            ),
            const SizedBox(height: 16),
            DateFieldWidget(
              labelText: 'Expiry Date',
              hintText: 'Expiry Date',
              icon: Icons.event_busy,
              isPurchasedDate: false,
              selectedDate: expiryDate,
              onDateTap: onExpiryDateTap,
            ),
            const SizedBox(height: 16),
            DateFieldWidget(
              labelText: 'Production Date',
              hintText: 'Production Date',
              icon: Icons.date_range,
              isPurchasedDate: false,
              selectedDate: productionDate,
              onDateTap: onProductionDateTap,
            ),
            if (dateError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  dateError,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            MedicineFormFields.buildDropdown(
              label: 'Status',
              icon: Icons.info,
              items: statuses,
              value: selectedStatus,
              onChanged: onStatusChanged,
            ),
            const SizedBox(height: 16),
            MedicineTextField(
              labelText: 'Donor Info',
              hintText: 'Donor Info',
              prefixIcon: Icons.person,
              controller: donorInfoController,
              onSaved: onDonorInfoSaved,
            ),
            const SizedBox(height: 16),
            MedicineFormFields.buildDropdown(
              label: 'Physical Condition',
              icon: Icons.medical_services,
              items: conditions,
              value: selectedCondition,
              onChanged: onConditionChanged,
            ),
            const SizedBox(height: 16),
            MedicineTextField(
              labelText: 'Notes',
              hintText: 'Notes',
              prefixIcon: Icons.note,
              controller: notesController,
              maxLines: 3,
              onSaved: onNotesSaved,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomHomeButton(
                text: 'Add Medicine',
                style: TextStyles.textstyle18,
                onPressed: onAddPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Global key for accessing context
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); 