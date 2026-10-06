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

abstract final class ChecklistRules {
  static GoLiveChecklist build(int facilityId, ChecklistFacts f) {
    final items = [
      ChecklistItem(
        key: ChecklistKey.verified,
        label: 'Verified by a platform admin',
        done: f.verified,
      ),
      ChecklistItem(
        key: ChecklistKey.hospitalAdminAccepted,
        label: 'A hospital admin has accepted their invite',
        done: f.hospitalAdminCount > 0,
      ),
      ChecklistItem(
        key: ChecklistKey.deskStaffActive,
        label: 'At least one desk staff account active',
        done: f.activeDeskStaffCount > 0,
      ),
      ChecklistItem(
        key: ChecklistKey.capabilitiesAndHours,
        label: 'Capabilities and opening hours set',
        done: f.capabilityCount > 0 && f.hasOpeningHours,
      ),
      ChecklistItem(
        key: ChecklistKey.deskPhoneConfirmed,
        label: 'Desk phone confirmed',
        done: f.deskPhoneConfirmed,
      ),
      ChecklistItem(
        key: ChecklistKey.trainingCompleted,
        label: 'Training mode completed',
        done: f.trainingCompleted,
      ),
      ChecklistItem(
        key: ChecklistKey.firstRealStatus,
        label: 'First real status update submitted',
        done: f.hasRealStatus,
      ),
    ];
    return GoLiveChecklist(
      facilityId: facilityId,
      items: items,
      complete: items.every((i) => i.done),
    );
  }
}
