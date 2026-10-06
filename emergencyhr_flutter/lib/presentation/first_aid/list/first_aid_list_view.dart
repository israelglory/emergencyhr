import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'first_aid_list_viewmodel.dart';

class FirstAidListView extends StatelessWidget {
  const FirstAidListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstAidListViewModel>.nonReactive(
      viewModelBuilder: FirstAidListViewModel.new,
      builder: (context, model, _) => AppPage(
        title: FirstAidListViewModel.title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NoticeBanner(message: FirstAidListViewModel.disclaimer),
            const SizedBox(height: AppSpacing.x2),
            if (model.isEmpty)
              const EmptyState(
                icon: Icons.medical_services_outlined,
                title: 'First aid is loading',
                message: 'Connect to the internet once to download the cards.',
              ),
            for (final row in model.rows) ...[
              ChoiceTile(
                title: row.title,
                subtitle: row.summary,
                onTap: () => model.open(row.type),
              ),
              const SizedBox(height: AppSpacing.x1),
            ],
          ],
        ),
      ),
    );
  }
}
