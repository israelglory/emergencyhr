import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';

import 'components/first_aid_content.dart';

abstract final class FirstAidPresenter {
  static FirstAidDisplay display(FirstAidCard c) => (
    title: c.title,
    summary: c.summary,
    doSteps: c.doSteps,
    dontSteps: c.dontSteps,
    // Unreviewed content is labelled in debug builds only.
    showDraft: kDebugMode && (c.reviewedBy == null || c.reviewedBy!.isEmpty),
  );
}
