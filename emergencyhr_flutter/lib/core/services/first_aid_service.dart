import 'dart:async';
import 'dart:convert';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/services.dart';

import '../../data/api/profile_api.dart';
import '../../data/local/base/local_storage_service.dart';
import '../../data/local/base/storage_keys.dart';

/// First-aid cards that work offline: bundled copy first, then the cached
/// server copy, refreshed in the background.
class FirstAidService {
  FirstAidService(
    this._api, {
    AssetBundle? bundle,
    LocalStorageService? storage,
  }) : _bundle = bundle ?? rootBundle,
       _storageOverride = storage;

  final ProfileApi _api;
  final AssetBundle _bundle;
  final LocalStorageService? _storageOverride;
  LocalStorageService get _storage =>
      _storageOverride ?? LocalStorageService.app();

  Map<EmergencyType, FirstAidCard> _cards = {};

  List<FirstAidCard> get cards =>
      _cards.values.toList()..sort((a, b) => a.type.index - b.type.index);

  FirstAidCard? forType(EmergencyType type) =>
      _cards[type] ?? _cards[EmergencyType.other];

  Future<void> init() async {
    await _loadBundled();
    _loadCached();
    unawaited(refresh());
  }

  Future<void> refresh() async {
    final response = await _api.firstAidCards();
    if (!response.success || response.data!.isEmpty) return;
    _apply(response.data!);
    await _storage.saveJson(StorageKeys.firstAidCards, [
      for (final c in response.data!) c.toJson(),
    ]);
  }

  Future<void> _loadBundled() async {
    for (final type in EmergencyType.values) {
      try {
        final raw = await _bundle.loadString(
          'assets/first_aid/${type.name}.json',
        );
        final card = FirstAidCard.fromJson(
          jsonDecode(raw) as Map<String, dynamic>,
        );
        _cards[card.type] = card;
      } catch (_) {
        // A missing bundled card is filled from the server copy.
      }
    }
  }

  void _loadCached() {
    final json = _storage.readJson(StorageKeys.firstAidCards);
    if (json is! List) return;
    try {
      _apply([
        for (final c in json) FirstAidCard.fromJson(c as Map<String, dynamic>),
      ]);
    } catch (_) {}
  }

  void _apply(List<FirstAidCard> cards) {
    _cards = {..._cards, for (final c in cards) c.type: c};
  }
}
