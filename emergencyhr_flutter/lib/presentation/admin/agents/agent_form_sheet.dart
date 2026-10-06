import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'agent_form_viewmodel.dart';

class AgentFormSheet extends StatelessWidget {
  const AgentFormSheet({super.key, this.userId, this.areas = const []});

  final int? userId;
  final List<String> areas;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgentFormViewModel>.reactive(
      viewModelBuilder: () => AgentFormViewModel(userId: userId, areas: areas),
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
            if (model.isNew) ...[
              AppTextField(
                label: 'Name',
                controller: model.nameController,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.x2),
              AppTextField(
                label: 'Phone number',
                controller: model.phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.x2),
            ],
            const AppText.label('Areas'),
            const SizedBox(height: AppSpacing.x1),
            ChipGroup(items: model.areaOptions, onSelected: model.toggleArea),
            const SizedBox(height: AppSpacing.x3),
            AppButton(
              title: 'Save',
              loading: model.isBusy,
              onPressed: model.save,
            ),
          ],
        ),
      ),
    );
  }
}
