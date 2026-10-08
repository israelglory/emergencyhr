import '../../../generated/protocol.dart';
import 'bot_actions.dart';
import 'bot_message.dart';

/// A place people can pick when they cannot share their location. Keep in
/// step with the app's `PilotAreas`.
typedef BotArea = ({String name, double lat, double lng});

/// Every word the Telegram bot says, built from plain data. No database
/// access, so it is covered by fast unit tests.
abstract final class BotCopy {
  static const maxResults = 5;

  static const shareLocation = 'Share my location';
  static const pickArea = 'Pick my area';
  static const updateStatus = 'Update hospital status';

  static const List<BotArea> areas = [
    (name: 'Ikeja', lat: 6.6018, lng: 3.3515),
    (name: 'Yaba', lat: 6.5095, lng: 3.3711),
    (name: 'Surulere', lat: 6.4969, lng: 3.3481),
    (name: 'Lekki', lat: 6.4474, lng: 3.4723),
    (name: 'Victoria Island', lat: 6.4281, lng: 3.4219),
    (name: 'Ikorodu', lat: 6.6194, lng: 3.5105),
    (name: 'Ogbomoso', lat: 8.1335, lng: 4.2410),
  ];

  /// "What happened" choices, as in the app. `skipped` means any.
  static const types = [
    EmergencyType.roadAccident,
    EmergencyType.severeBleeding,
    EmergencyType.burns,
    EmergencyType.chestPain,
    EmergencyType.pregnancy,
    EmergencyType.child,
    EmergencyType.unconscious,
    EmergencyType.breathingDifficulty,
    EmergencyType.skipped,
  ];

  static String typeLabel(EmergencyType type) => switch (type) {
    EmergencyType.roadAccident => 'Road accident',
    EmergencyType.severeBleeding => 'Severe bleeding',
    EmergencyType.burns => 'Burns',
    EmergencyType.chestPain => 'Chest pain',
    EmergencyType.pregnancy => 'Pregnancy',
    EmergencyType.child => 'Child',
    EmergencyType.unconscious => 'Unconscious',
    EmergencyType.breathingDifficulty => 'Breathing difficulty',
    EmergencyType.other => 'Something else',
    EmergencyType.skipped => 'Any emergency',
  };

  static List<List<KeyboardButton>> keyboard({required bool staff}) => [
    [const KeyboardButton(shareLocation, requestLocation: true)],
    [const KeyboardButton(pickArea)],
    if (staff) [const KeyboardButton(updateStatus)],
  ];

  static BotMessage welcome({required bool staff}) => BotMessage(
    '<b>EmergencyHr</b> finds hospitals near you that can take a patient '
    'right now.\n\n'
    'Tap <b>$shareLocation</b> below, or <b>$pickArea</b>.\n\n'
    'If someone is in immediate danger, call <b>112</b>.'
    '${staff ? '\n\nHospital staff: tap <b>$updateStatus</b>.' : ''}',
    keyboard: keyboard(staff: staff),
  );

  static BotMessage areaPicker() => BotMessage(
    'Which area are you in?',
    buttons: [
      for (var i = 0; i < areas.length; i += 2)
        [
          for (var j = i; j < i + 2 && j < areas.length; j++)
            BotButton.callback(areas[j].name, 'a:$j'),
        ],
    ],
  );

  /// Matches the app's freshness wording.
  static String freshnessLabel(
    FreshnessTier tier,
    DateTime? updatedAt,
    DateTime now,
  ) {
    final ago = updatedAt == null
        ? null
        : now.difference(updatedAt).inMinutes.clamp(0, 1 << 30);
    return switch (tier) {
      FreshnessTier.fresh =>
        'Accepting emergencies. Confirmed '
            '${ago == 0 ? 'just now' : '$ago min ago'}.',
      FreshnessTier.stale => 'Last confirmed $ago min ago. Call ahead.',
      FreshnessTier.unverified => 'Unverified. Call before going.',
      FreshnessTier.paused => 'Not accepting new emergencies',
    };
  }

  static String _km(double km) =>
      km < 10 ? km.toStringAsFixed(1) : km.round().toString();

  static String _coord(double v) => v.toStringAsFixed(5);

  static String directionsUrl(double lat, double lng) =>
      'https://www.google.com/maps/dir/?api=1&destination='
      '${_coord(lat)},${_coord(lng)}';

  /// The ranked hospitals for a place, with directions buttons and the
  /// "What happened" filter.
  static BotMessage results({
    required List<EmergencyResult> ranked,
    required bool showCall112,
    required EmergencyType type,
    required double lat,
    required double lng,
    required DateTime now,
    String? areaName,
  }) {
    final shown = ranked.where((r) => r.rankTier > 0).take(maxResults).toList();
    final b = StringBuffer(
      '<b>Hospitals ${areaName == null ? 'near you' : 'near ${BotMessage.escape(areaName)}'}</b>',
    );
    if (type != EmergencyType.skipped) b.write(' · ${typeLabel(type)}');
    b.write('\n');
    if (shown.isEmpty) {
      b.write(
        '\nNo hospitals found within 25 km. Call <b>112</b> for help now.',
      );
    } else {
      if (showCall112) {
        b.write(
          '\nNo hospital within 25 km is confirmed as accepting. Call '
          '<b>112</b>, or call a hospital below before going.\n',
        );
      } else {
        b.write('Sorted by who can take a patient now.\n');
      }
      for (var i = 0; i < shown.length; i++) {
        final r = shown[i];
        b
          ..write('\n${i + 1}. <b>${BotMessage.escape(r.name)}</b>\n')
          ..write(freshnessLabel(r.freshness, r.statusUpdatedAt, now))
          ..write('\n${_km(r.distanceKm)} km, about ${r.etaMinutes} min');
        if (r.freshness == FreshnessTier.fresh ||
            r.freshness == FreshnessTier.stale) {
          if (r.erBedsFree != null) b.write(' · ER beds ${r.erBedsFree}');
          if (r.icuBedsFree != null) b.write(' · ICU beds ${r.icuBedsFree}');
          if (r.depositRequired == true) b.write(' · Deposit required');
        }
        b.write(
          r.deskPhone == null
              ? '\nNo phone number listed.\n'
              : '\nCall ${BotMessage.escape(r.deskPhone!)}\n',
        );
      }
      b.write(
        '\nIf someone is in immediate danger, call <b>112</b>.\n'
        '<i>Some locations from GRID3 (CC BY 4.0).</i>',
      );
    }
    final lat5 = _coord(lat);
    final lng5 = _coord(lng);
    return BotMessage(
      b.toString(),
      buttons: [
        for (var i = 0; i < shown.length; i++)
          [
            BotButton.url(
              'Directions: ${i + 1}. ${_short(shown[i].name)}',
              directionsUrl(shown[i].lat, shown[i].lng),
            ),
          ],
        for (var i = 0; i < types.length; i += 3)
          [
            for (var j = i; j < i + 3 && j < types.length; j++)
              BotButton.callback(
                types[j] == type
                    ? '• ${typeLabel(types[j])}'
                    : typeLabel(types[j]),
                't:${types[j].name}:$lat5:$lng5',
              ),
          ],
      ],
    );
  }

  static String _short(String name) =>
      name.length <= 32 ? name : '${name.substring(0, 31)}…';

  static String ago(DateTime at, DateTime now) {
    final minutes = now.difference(at).inMinutes.clamp(0, 1 << 30);
    if (minutes < 1) return 'just now';
    if (minutes < 60) return '$minutes min ago';
    final hours = minutes ~/ 60;
    if (hours < 48) return '$hours h ago';
    return '${hours ~/ 24} days ago';
  }

  static String _summary(bool accepting, int er, int icu) =>
      '${accepting ? 'Accepting' : 'Paused'} · ER beds $er · ICU beds $icu';

  /// The staff panel: the saved status, the unsaved changes and the
  /// buttons to change and save them.
  static BotMessage panel({
    required Facility facility,
    required FacilityStatus? saved,
    required StatusDraft draft,
    required DateTime now,
    String? notice,
  }) {
    final b = StringBuffer('<b>${BotMessage.escape(facility.name)}</b>\n');
    if (notice != null) b.write('$notice\n');
    b.write(
      saved == null
          ? '\nNo status sent yet.'
          : '\nNow: ${_summary(saved.accepting, saved.erBedsFree, saved.icuBedsFree)}'
                '\nUpdated ${ago(saved.updatedAt, now)}',
    );
    final changed = !draft.sameAs(saved);
    if (changed) {
      b.write(
        '\n\n<b>New:</b> ${_summary(draft.accepting, draft.erBeds, draft.icuBeds)}'
        '\nTap Save update to publish it.',
      );
    } else {
      b.write('\n\nChange it below, or tap Still accurate.');
    }
    if (facility.onboardingStage != OnboardingStage.live) {
      b.write(
        '\n\n<i>Not public yet. Updates appear once the hospital is '
        'verified and live.</i>',
      );
    }
    b.write(
      '\n<i>Doctor on duty and deposit stay as they are. Change them in '
      'the app.</i>',
    );
    return BotMessage(
      b.toString(),
      buttons: [
        [
          BotButton.callback(
            draft.accepting ? '✅ Accepting' : 'Accepting',
            draft.copyWith(accepting: true).editData,
          ),
          BotButton.callback(
            draft.accepting ? 'Paused' : '⏸ Paused',
            draft.copyWith(accepting: false).editData,
          ),
        ],
        [
          BotButton.callback(
            'ER −',
            draft.copyWith(erBeds: draft.erBeds - 1).editData,
          ),
          BotButton.callback('ER beds ${draft.erBeds}', 'n'),
          BotButton.callback(
            'ER +',
            draft.copyWith(erBeds: draft.erBeds + 1).editData,
          ),
        ],
        [
          BotButton.callback(
            'ICU −',
            draft.copyWith(icuBeds: draft.icuBeds - 1).editData,
          ),
          BotButton.callback('ICU beds ${draft.icuBeds}', 'n'),
          BotButton.callback(
            'ICU +',
            draft.copyWith(icuBeds: draft.icuBeds + 1).editData,
          ),
        ],
        [
          if (changed || saved == null)
            BotButton.callback('Save update', draft.saveData)
          else
            BotButton.callback('Still accurate', 'c:${draft.facilityId}'),
        ],
      ],
    );
  }

  static BotMessage facilityPicker(List<Facility> facilities) => BotMessage(
    'Which hospital?',
    buttons: [
      for (final f in facilities)
        [BotButton.callback(_short(f.name), 'f:${f.id}')],
    ],
  );

  static const notStaff =
      'Status updates are for hospital staff. In the EmergencyHr app, open '
      'your hospital\'s Status page and tap Connect Telegram.';

  static BotMessage linked(String? name) => BotMessage(
    'Connected${name == null ? '' : ' as ${BotMessage.escape(name)}'}. '
    'Tap <b>$updateStatus</b> any time to update your hospital.\n\n'
    'To disconnect, send /disconnect.',
    keyboard: keyboard(staff: true),
  );

  static const linkInvalid =
      'This link has expired or was already used. In the app, tap Connect '
      'Telegram again for a new one.';

  static BotMessage disconnected() => BotMessage(
    'Disconnected. This Telegram account can no longer update hospital '
    'status.',
    keyboard: keyboard(staff: false),
  );
}
