import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'not_found_viewmodel.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotFoundViewModel>.nonReactive(
      viewModelBuilder: NotFoundViewModel.new,
      builder: (context, model, _) => AppPage(
        scrollable: false,
        body: EmptyState(
          icon: Icons.search_off_outlined,
          title: NotFoundViewModel.title,
          message: NotFoundViewModel.message,
          actionLabel: 'Go to home',
          onAction: model.goHome,
        ),
      ),
    );
  }
}
