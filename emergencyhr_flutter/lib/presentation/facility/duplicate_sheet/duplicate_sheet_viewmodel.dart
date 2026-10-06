import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

/// What the user chose when possible duplicates were found.
sealed class DuplicateChoice {
  const DuplicateChoice();
}

class UseExistingListing extends DuplicateChoice {
  const UseExistingListing(this.facilityId);
  final int facilityId;
}

class CreateNewListing extends DuplicateChoice {
  const CreateNewListing();
}

typedef DuplicateRow = ({String name, String detail, bool strong, int id});

class DuplicateSheetViewModel extends BaseViewModel {
  DuplicateSheetViewModel({
    required this.candidates,
    BottomSheetService? sheets,
  }) : _sheets = sheets ?? bottomSheetService;

  final List<DuplicateCandidate> candidates;
  final BottomSheetService _sheets;

  bool get hasStrongMatch => candidates.any((c) => c.strong);

  String get title => hasStrongMatch
      ? 'This hospital may already be listed'
      : 'Is it one of these?';

  String get message => hasStrongMatch
      ? 'To avoid duplicates, use the existing listing.'
      : 'These listings are close by. Pick one if it is the same hospital.';

  /// Creating is blocked when a strong match exists (the server enforces it).
  bool get canCreateNew => !hasStrongMatch;

  List<DuplicateRow> get rows => [
    for (final c in candidates)
      (
        name: c.facility.name,
        detail:
            '${c.address} · ${Formatters.distanceKm(c.distanceMeters / 1000)} away',
        strong: c.strong,
        id: c.facility.id,
      ),
  ];

  void useExisting(int id) =>
      _sheets.dismiss<DuplicateChoice>(UseExistingListing(id));

  void createNew() =>
      _sheets.dismiss<DuplicateChoice>(const CreateNewListing());
}
