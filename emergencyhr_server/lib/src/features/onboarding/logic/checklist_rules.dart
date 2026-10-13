import '../../../generated/protocol.dart';

/// Inputs for the go-live checklist, gathered from the database.
class ChecklistFacts {
  const ChecklistFacts({
    required this.verified,
    required this.hospitalAdminCount,
    required this.activeDeskStaffCount,
    required this.capabilityCount,
    required this.hasOpeningHours,
    required this.deskPhoneConfirmed,
    required this.trainingCompleted,
    required this.hasRealStatus,
  });

  final bool verified;
  final int hospitalAdminCount;
  final int activeDeskStaffCount;
  final int capabilityCount;
  final bool hasOpeningHours;
  final bool deskPhoneConfirmed;
  final bool trainingCompleted;
  final bool hasRealStatus;
}

/// Go-live needs a verified listing, a hospital admin and one real status
/// update (owner's rule, docs/DECISIONS.md 60). The other items are shown
/// as optional good practice.
abstract final class ChecklistRules {
  static const requiredKeys = {
    ChecklistKey.verified,
    ChecklistKey.hospitalAdminAccepted,
    ChecklistKey.firstRealStatus,
  };

  static ChecklistItem _item(ChecklistKey key, String label, bool done) =>
      ChecklistItem(
        key: key,
        label: label,
        done: done,
        required: requiredKeys.contains(key),
      );

  static GoLiveChecklist build(int facilityId, ChecklistFacts f) {
    final items = [
      _item(
        ChecklistKey.verified,
        'Verified by a platform admin',
        f.verified,
      ),
      _item(
        ChecklistKey.hospitalAdminAccepted,
        'A hospital admin has accepted their invite',
        f.hospitalAdminCount > 0,
      ),
      _item(
        ChecklistKey.deskStaffActive,
        'At least one desk staff account active',
        f.activeDeskStaffCount > 0,
      ),
      _item(
        ChecklistKey.capabilitiesAndHours,
        'Capabilities and opening hours set',
        f.capabilityCount > 0 && f.hasOpeningHours,
      ),
      _item(
        ChecklistKey.deskPhoneConfirmed,
        'Desk phone confirmed',
        f.deskPhoneConfirmed,
      ),
      _item(
        ChecklistKey.trainingCompleted,
        'Training mode completed',
        f.trainingCompleted,
      ),
      _item(
        ChecklistKey.firstRealStatus,
        'First real status update submitted',
        f.hasRealStatus,
      ),
    ];
    return GoLiveChecklist(
      facilityId: facilityId,
      items: items,
      complete: items.where((i) => i.required).every((i) => i.done),
    );
  }
}

/// Progress against what is needed to go live.
extension ChecklistProgress on GoLiveChecklist {
  int get requiredDone => items.where((i) => i.required && i.done).length;
  int get requiredTotal => items.where((i) => i.required).length;
}
