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
        title: 'Home',
        body: SectionColumn(
          gap: 14,
          children: [
            const AppText.headline(FirstAidListViewModel.title),
            const AppText.caption(FirstAidListViewModel.disclaimer),
            if (model.isEmpty)
              const EmptyState(
                icon: Icons.medical_services_outlined,
                title: 'First aid is loading',
                message: 'Connect to the internet once to download the cards.',
              )
            else
              AppListCard(
                children: [
                  for (final row in model.rows)
                    AppListRow(
                      title: row.title,
                      subtitle: row.summary,
                      titleTone: AppTextTone.primary,
                      onTap: row.onTap,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
