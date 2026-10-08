import '../../../generated/protocol.dart';

/// What a button tap asks for. Button data is at most 64 bytes, so the
/// state the bot needs travels inside it and nothing is kept per chat.
sealed class BotAction {
  const BotAction();

  /// Reads a button's data. Unknown or malformed data gives null.
  static BotAction? parse(String data) {
    final parts = data.split(':');
    int? n(int i) => i < parts.length ? int.tryParse(parts[i]) : null;
    double? d(int i) => i < parts.length ? double.tryParse(parts[i]) : null;
    switch (parts.first) {
      case 'a':
        final index = n(1);
        return index == null ? null : PickArea(index);
      case 't':
        final type = EmergencyType.values
            .where((t) => t.name == (parts.length > 1 ? parts[1] : ''))
            .firstOrNull;
        final lat = d(2);
        final lng = d(3);
        if (type == null || lat == null || lng == null) return null;
        return FilterType(type, lat, lng);
      case 'f':
        final id = n(1);
        return id == null ? null : OpenPanel(id);
      case 'd' || 'v':
        final id = n(1);
        final accepting = n(2);
        final er = n(3);
        final icu = n(4);
        if (id == null || accepting == null || er == null || icu == null) {
          return null;
        }
        final draft = StatusDraft(
          facilityId: id,
          accepting: accepting == 1,
          erBeds: er,
          icuBeds: icu,
        );
        return parts.first == 'v' ? SaveDraft(draft) : EditDraft(draft);
      case 'c':
        final id = n(1);
        return id == null ? null : ConfirmStatus(id);
      case 'n':
        return const Noop();
    }
    return null;
  }
}

class PickArea extends BotAction {
  const PickArea(this.index);
  final int index;
}

class FilterType extends BotAction {
  const FilterType(this.type, this.lat, this.lng);
  final EmergencyType type;
  final double lat;
  final double lng;
}

class OpenPanel extends BotAction {
  const OpenPanel(this.facilityId);
  final int facilityId;
}

class EditDraft extends BotAction {
  const EditDraft(this.draft);
  final StatusDraft draft;
}

class SaveDraft extends BotAction {
  const SaveDraft(this.draft);
  final StatusDraft draft;
}

class ConfirmStatus extends BotAction {
  const ConfirmStatus(this.facilityId);
  final int facilityId;
}

/// A tap on a label button that does nothing.
class Noop extends BotAction {
  const Noop();
}

/// The staff panel's unsaved changes. Doctor on duty and deposit are kept
/// from the saved status; they are changed in the app.
class StatusDraft {
  const StatusDraft({
    required this.facilityId,
    required this.accepting,
    required this.erBeds,
    required this.icuBeds,
  });

  static const maxBeds = 999;

  final int facilityId;
  final bool accepting;
  final int erBeds;
  final int icuBeds;

  factory StatusDraft.from(int facilityId, FacilityStatus? status) =>
      StatusDraft(
        facilityId: facilityId,
        accepting: status?.accepting ?? true,
        erBeds: status?.erBedsFree ?? 0,
        icuBeds: status?.icuBedsFree ?? 0,
      );

  StatusDraft copyWith({bool? accepting, int? erBeds, int? icuBeds}) =>
      StatusDraft(
        facilityId: facilityId,
        accepting: accepting ?? this.accepting,
        erBeds: (erBeds ?? this.erBeds).clamp(0, maxBeds),
        icuBeds: (icuBeds ?? this.icuBeds).clamp(0, maxBeds),
      );

  bool sameAs(FacilityStatus? status) =>
      status != null &&
      status.accepting == accepting &&
      status.erBedsFree == erBeds &&
      status.icuBedsFree == icuBeds;

  String _fields() => '$facilityId:${accepting ? 1 : 0}:$erBeds:$icuBeds';
  String get editData => 'd:${_fields()}';
  String get saveData => 'v:${_fields()}';
}
