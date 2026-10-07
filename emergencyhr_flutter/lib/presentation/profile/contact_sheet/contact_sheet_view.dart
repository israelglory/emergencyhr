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
      builder: (context, model, _) => AppSheet(
        title: model.title,
        children: [
          AppTextField(
            label: 'Name',
            controller: model.nameController,
            textCapitalization: TextCapitalization.words,
            errorText: model.errorFor('name'),
          ),
          AppTextField(
            label: 'Phone number',
            controller: model.phoneController,
            keyboardType: TextInputType.phone,
            errorText: model.errorFor('phone'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.label('Send alerts by'),
              const SizedBox(height: 6),
              RadioOptionList(
                items: model.channelOptions,
                onSelected: model.setChannel,
                inCard: true,
              ),
            ],
          ),
          AppButton(
            title: 'Save contact',
            loading: model.isBusy,
            onPressed: model.save,
          ),
        ],
      ),
    );
  }
}
