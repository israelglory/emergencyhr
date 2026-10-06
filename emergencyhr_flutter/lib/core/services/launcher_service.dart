import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Phone calls, maps, SMS composer and clipboard. Platform checks live here,
/// never in UI code.
class LauncherService {
  /// True on phones, where `tel:` reliably opens the dialler.
  bool get canDialDirectly =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  bool get _prefersAppleMaps =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  /// Whether this platform can open an SMS composer.
  bool get canComposeSms => canDialDirectly;

  Future<bool> call(String phone) => _launch(Uri(scheme: 'tel', path: phone));

  Future<bool> openDirections({
    required double lat,
    required double lng,
    required String label,
  }) {
    final uri = _prefersAppleMaps
        ? Uri.https('maps.apple.com', '/', {
            'daddr': '$lat,$lng',
            'q': label,
            'dirflg': 'd',
          })
        : Uri.https('www.google.com', '/maps/dir/', {
            'api': '1',
            'destination': '$lat,$lng',
            'travelmode': 'driving',
          });
    return _launch(uri, mode: LaunchMode.externalApplication);
  }

  /// A shareable map link for messages.
  Uri mapsLink(double lat, double lng) =>
      Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$lat,$lng',
      });

  Future<bool> composeSms(List<String> recipients, String body) {
    final separator = defaultTargetPlatform == TargetPlatform.iOS ? ',' : ';';
    final uri = Uri(
      scheme: 'sms',
      path: recipients.join(separator),
      queryParameters: {'body': body},
    );
    return _launch(uri);
  }

  Future<bool> openUrl(Uri uri) =>
      _launch(uri, mode: LaunchMode.externalApplication);

  Future<void> copy(String text) =>
      Clipboard.setData(ClipboardData(text: text));

  Future<bool> _launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      return await launchUrl(uri, mode: mode, webOnlyWindowName: '_blank');
    } on PlatformException {
      return false;
    }
  }
}
