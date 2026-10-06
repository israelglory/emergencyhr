import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'contact_sheet_viewmodel.dart';

class ContactSheetView extends StatelessWidget {
  const ContactSheetView({super.key, this.contact});

  final EmergencyContact? contact;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactSheetViewModel>.reactive(
      viewModelBuilder: () => ContactSheetViewModel(contact: contact),
      builder: (context, model, _) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.x3,
          0,
          AppSpacing.x3,
          AppSpacing.x3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.title(model.title),
            const SizedBox(height: AppSpacing.x2),
            AppTextField(
              label: 'Name',
              controller: model.nameController,
              textCapitalization: TextCapitalization.words,
              errorText: model.errorFor('name'),
            ),
            const SizedBox(height: AppSpacing.x2),
            AppTextField(
              label: 'Phone number',
              controller: model.phoneController,
              keyboardType: TextInputType.phone,
              errorText: model.errorFor('phone'),
            ),
            const SizedBox(height: AppSpacing.x2),
            const AppText.label('Send alerts by'),
            const SizedBox(height: AppSpacing.x1),
            ChipGroup(
              items: model.channelOptions,
              onSelected: model.setChannel,
            ),
            const SizedBox(height: AppSpacing.x3),
            AppButton(
              title: 'Save contact',
              loading: model.isBusy,
              onPressed: model.save,
            ),
          ],
        ),
      ),
    );
  }
}
