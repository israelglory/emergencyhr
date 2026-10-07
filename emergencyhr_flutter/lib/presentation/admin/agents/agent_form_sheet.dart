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
      builder: (context, model, _) => AppSheet(
        title: model.title,
        children: [
          if (model.isNew) ...[
            const AppText.caption(AgentFormViewModel.addExplainer),
            AppTextField(
              label: 'Their account email',
              controller: model.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText.label('Areas'),
              const SizedBox(height: 6),
              CheckboxGrid(
                items: model.areaOptions,
                onToggle: model.toggleArea,
              ),
            ],
          ),
          AppButton(
            title: 'Save',
            loading: model.isBusy,
            onPressed: model.save,
          ),
        ],
      ),
    );
  }
}
