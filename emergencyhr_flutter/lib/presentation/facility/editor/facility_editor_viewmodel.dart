import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/facility_api.dart';
import '../../../data/local/draft_storage.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/pilot_areas.dart';
import '../../../data/models/route_args.dart';
import '../../../data/models/shell_kind.dart';
import '../duplicate_sheet/duplicate_sheet_view.dart';
import '../duplicate_sheet/duplicate_sheet_viewmodel.dart';

typedef ChipOption<T> = ({String label, T value, bool selected});

/// Create or edit a facility listing. New listings run the duplicate check
/// first, and unsent drafts are kept on the device.
class FacilityEditorViewModel extends BaseViewModel {
  FacilityEditorViewModel({
    required this.args,
    FacilityApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
    DialogService? dialogs,
    LocationService? location,
    DraftStorage? drafts,
  }) : _api = api ?? locator<FacilityApi>(),
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService,
       _sheets = sheets ?? bottomSheetService,
       _dialogs = dialogs ?? dialogService,
       _location = location ?? locationService,
       _drafts = drafts ?? DraftStorage();

  final FacilityEditorArgs args;
  final FacilityApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;
  final BottomSheetService _sheets;
  final DialogService _dialogs;
  final LocationService _location;
  final DraftStorage _drafts;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final deskPhoneController = TextEditingController();
  final contactNameController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  FacilityType _type = FacilityType.private;
  String _area = PilotAreas.all.first.name;
  final Set<Capability> _capabilities = {Capability.generalEmergency};
  bool _alwaysOpen = true;
  final Set<int> _openDays = {1, 2, 3, 4, 5, 6};
  TimeOfDay _opens = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _closes = const TimeOfDay(hour: 20, minute: 0);

  Map<String, String> _errors = {};
  bool _loaded = false;
  bool _savedOffline = false;
  Timer? _retryTimer;

  static const _locateKey = 'locate';
  static const _saveKey = 'save';

  bool get isNew => args.facilityId == null;
  String get title => isNew ? 'Onboarding' : 'Hospital';
  String get heading => isNew ? 'New hospital listing' : 'Hospital details';
  String get saveLabel => isNew ? 'Check and create listing' : 'Save details';
  bool get isLoading => !_loaded && !hasError;
  String? get errorMessage => modelError?.toString();
  bool get isSaving => busy(_saveKey);
  bool get isLocating => busy(_locateKey);

  bool get savedOffline => _savedOffline;
  static const offlineNotice =
      'Saved on this device. We will send it when you are back online.';

  String? errorFor(String field) => _errors[field];

  List<ChipOption<FacilityType>> get typeOptions => [
    for (final t in FacilityType.values)
      (label: t.label.split(' ').first, value: t, selected: t == _type),
  ];

  List<ChipOption<Capability>> get capabilityOptions => [
    for (final c in Capability.values)
      (label: c.label, value: c, selected: _capabilities.contains(c)),
  ];

  List<({String value, String label})> get areaOptions => [
    for (final a in PilotAreas.names) (value: a, label: a),
  ];
  String get area => _area;

  bool get alwaysOpen => _alwaysOpen;
  String get alwaysOpenLabel => _alwaysOpen ? 'Yes' : 'No';
  List<ChipOption<int>> get dayOptions => [
    for (final (i, d) in const [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ].indexed)
      (label: d, value: i + 1, selected: _openDays.contains(i + 1)),
  ];
  String get opensLabel => 'Opens ${_fmt(_opens)}';
  String get closesLabel => 'Closes ${_fmt(_closes)}';

  String get pinLabel {
    final lat = double.tryParse(latController.text);
    final lng = double.tryParse(lngController.text);
    if (lat == null || lng == null) return 'No map pin yet';
    return 'Map pin ${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
  }

  Future<void> onReady() async {
    if (isNew) {
      final draft = _drafts.readFacilityDraft();
      if (draft != null && args.name == null) {
        _apply(draft);
        _snackbar.info(message: 'Restored your unsent draft');
      } else {
        nameController.text = args.name ?? '';
        if (args.lat != null) latController.text = '${args.lat}';
        if (args.lng != null) lngController.text = '${args.lng}';
        if (args.lat == null) await useMyLocation();
      }
      _loaded = true;
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(_api.detail(args.facilityId!));
    if (!response.success) {
      setError(response.message);
    } else {
      final d = response.data!;
      final f = d.facility;
      _apply(
        FacilityProfileInput(
          name: f.name,
          type: f.type,
          address: f.address,
          area: f.area,
          lat: f.lat,
          lng: f.lng,
          deskPhone: f.deskPhone,
          contactName: f.contactName,
          contactPhone: f.contactPhone,
          openingHours: f.openingHours,
          capabilities: d.capabilities,
        ),
      );
      _loaded = true;
    }
    notifyListeners();
  }

  void setType(FacilityType type) {
    _type = type;
    _changed();
  }

  void setArea(String? area) {
    if (area == null) return;
    _area = area;
    _changed();
  }

  void toggleCapability(Capability c) {
    _capabilities.contains(c) ? _capabilities.remove(c) : _capabilities.add(c);
    _errors.remove('capabilities');
    _changed();
  }

  void setAlwaysOpen(bool value) {
    _alwaysOpen = value;
    _changed();
  }

  void toggleDay(int day) {
    _openDays.contains(day) ? _openDays.remove(day) : _openDays.add(day);
    _changed();
  }

  Future<void> pickOpens() async {
    final t = await _dialogs.pickTime(_opens);
    if (t == null) return;
    _opens = t;
    _changed();
  }

  Future<void> pickCloses() async {
    final t = await _dialogs.pickTime(_closes);
    if (t == null) return;
    _closes = t;
    _changed();
  }

  void onFieldChanged(String _) => _changed();

  Future<void> useMyLocation() async {
    final result = await runBusyFuture(
      _location.current(),
      busyObject: _locateKey,
    );
    switch (result) {
      case LocationFound(:final lat, :final lng):
        latController.text = lat.toStringAsFixed(6);
        lngController.text = lng.toStringAsFixed(6);
        _errors.remove('lat');
        _changed();
      case LocationDenied():
        _snackbar.info(message: 'Location is off. Enter the map pin by hand.');
      case LocationUnavailable():
        _snackbar.info(message: 'Could not get your location. Try again.');
    }
  }

  Future<void> save() async {
    final input = _buildInput();
    if (input == null) {
      notifyListeners();
      return;
    }
    if (!isNew) {
      final response = await runBusyFuture(
        _api.updateProfile(args.facilityId!, input),
        busyObject: _saveKey,
      );
      _handleFailure(response.success, response.message, response.field);
      if (response.success) {
        _snackbar.success(message: 'Details saved');
        _navigation.pop<bool>(true);
      }
      return;
    }

    final duplicates = await runBusyFuture(
      _api.findDuplicates(input.name, input.lat, input.lng),
      busyObject: _saveKey,
    );
    if (!duplicates.success) {
      _handleFailure(false, duplicates.message, duplicates.field);
      if (duplicates.offline) _queueRetry();
      return;
    }
    if (duplicates.data!.isNotEmpty) {
      final choice = await _sheets.show<DuplicateChoice>(
        DuplicateSheetView(candidates: duplicates.data!),
      );
      switch (choice) {
        case UseExistingListing(:final facilityId):
          await _drafts.clearFacilityDraft();
          await _openExisting(facilityId);
          return;
        case CreateNewListing():
          break;
        case null:
          return;
      }
    }
    await _create(input);
  }

  Future<void> _create(FacilityProfileInput input) async {
    final response = await runBusyFuture(
      _api.create(input),
      busyObject: _saveKey,
    );
    if (!response.success) {
      _handleFailure(false, response.message, response.field);
      if (response.offline) _queueRetry();
      return;
    }
    _retryTimer?.cancel();
    _savedOffline = false;
    await _drafts.clearFacilityDraft();
    _snackbar.success(message: 'Listing created');
    await _session.refresh();
    await _openCreated(response.data!.id!);
  }

  Future<void> _openCreated(int id) async {
    if (_session.canOpen(ShellKind.agent)) {
      await _navigation.replaceWith<void>(AppRoutes.agentFacility(id));
    } else if (_session.canOpen(ShellKind.admin)) {
      _navigation.pop<bool>(true);
    } else {
      _session.selectFacility(id);
      await _navigation.clearStackAndShow<void>(AppRoutes.desk);
    }
  }

  Future<void> _openExisting(int id) async {
    if (_session.canOpen(ShellKind.agent)) {
      await _navigation.replaceWith<void>(AppRoutes.agentFacility(id));
    } else {
      await _navigation.replaceWith<void>(AppRoutes.claim(id));
    }
  }

  void _queueRetry() {
    _savedOffline = true;
    _retryTimer?.cancel();
    _retryTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!isSaving) save();
    });
    notifyListeners();
  }

  void _handleFailure(bool ok, String? message, String? field) {
    if (ok) return;
    if (field != null) {
      _errors = {field: message!};
    } else {
      _snackbar.error(message: message!);
    }
    notifyListeners();
  }

  FacilityProfileInput? _buildInput() {
    final errors = <String, String>{};
    final lat = double.tryParse(latController.text.trim());
    final lng = double.tryParse(lngController.text.trim());
    if (nameController.text.trim().length < 3) {
      errors['name'] = 'Enter the hospital name.';
    }
    if (addressController.text.trim().isEmpty) {
      errors['address'] = 'Enter the address.';
    }
    if (lat == null || lng == null) {
      errors['lat'] = 'Set the map pin. Use your location or type it in.';
    }
    if (_capabilities.isEmpty) {
      errors['capabilities'] = 'Choose at least one capability.';
    }
    if (!_alwaysOpen && _openDays.isEmpty) {
      errors['openingHours'] = 'Choose the days the hospital is open.';
    }
    _errors = errors;
    if (errors.isNotEmpty) return null;
    return _currentInput(lat!, lng!);
  }

  FacilityProfileInput _currentInput(double lat, double lng) {
    String? opt(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    return FacilityProfileInput(
      name: nameController.text.trim(),
      type: _type,
      address: addressController.text.trim(),
      area: _area,
      lat: lat,
      lng: lng,
      deskPhone: opt(deskPhoneController),
      contactName: opt(contactNameController),
      contactPhone: opt(contactPhoneController),
      openingHours: OpeningHours(
        alwaysOpen: _alwaysOpen,
        periods: _alwaysOpen
            ? []
            : [
                for (final day in _openDays.toList()..sort())
                  OpeningPeriod(
                    weekday: day,
                    openMinute: _opens.hour * 60 + _opens.minute,
                    closeMinute: _closes.hour * 60 + _closes.minute,
                  ),
              ],
      ),
      capabilities: _capabilities.toList(),
    );
  }

  void _apply(FacilityProfileInput i) {
    nameController.text = i.name;
    addressController.text = i.address;
    deskPhoneController.text = i.deskPhone ?? '';
    contactNameController.text = i.contactName ?? '';
    contactPhoneController.text = i.contactPhone ?? '';
    latController.text = '${i.lat}';
    lngController.text = '${i.lng}';
    _type = i.type;
    if (PilotAreas.names.contains(i.area)) _area = i.area;
    _capabilities
      ..clear()
      ..addAll(i.capabilities);
    final hours = i.openingHours;
    _alwaysOpen = hours?.alwaysOpen ?? true;
    if (hours != null && hours.periods.isNotEmpty) {
      _openDays
        ..clear()
        ..addAll(hours.periods.map((p) => p.weekday));
      final p = hours.periods.first;
      _opens = TimeOfDay(hour: p.openMinute ~/ 60, minute: p.openMinute % 60);
      _closes = TimeOfDay(
        hour: (p.closeMinute ~/ 60) % 24,
        minute: p.closeMinute % 60,
      );
    }
  }

  void _changed() {
    if (isNew) {
      final lat = double.tryParse(latController.text) ?? 0;
      final lng = double.tryParse(lngController.text) ?? 0;
      _drafts.saveFacilityDraft(_currentInput(lat, lng));
    }
    notifyListeners();
  }

  static String _fmt(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    _retryTimer?.cancel();
    for (final c in [
      nameController,
      addressController,
      deskPhoneController,
      contactNameController,
      contactPhoneController,
      latController,
      lngController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }
}
