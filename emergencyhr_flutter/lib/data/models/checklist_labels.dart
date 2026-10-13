import 'package:emergencyhr_client/emergencyhr_client.dart';

/// How the go-live checklist reads in the app. Only required items block
/// going live; the rest are marked optional.
extension ChecklistItemLabel on ChecklistItem {
  String get displayLabel => required ? label : '$label (optional)';
}

extension GoLiveChecklistSummary on GoLiveChecklist {
  /// e.g. "2 of 3 needed to go live".
  String get requiredSummary {
    final needed = items.where((i) => i.required);
    final done = needed.where((i) => i.done).length;
    return '$done of ${needed.length} needed to go live';
  }
}
