import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../common/not_found/not_found_view.dart';
import '../components/first_aid_content.dart';
import 'first_aid_card_viewmodel.dart';

class FirstAidCardView extends StatelessWidget {
  const FirstAidCardView({super.key, required this.typeName});

  final String typeName;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstAidCardViewModel>.nonReactive(
      viewModelBuilder: () => FirstAidCardViewModel(typeName: typeName),
      builder: (context, model, _) {
        if (!model.found) return const NotFoundView();
        return AppPage(
          title: 'First aid',
          bottom: AppButton.secondary(
            title: 'Call 112',
            icon: Icons.call_outlined,
            onPressed: model.call112,
          ),
          body: FirstAidContent(card: model.card!),
        );
      },
    );
  }
}
