import '../widgets/call_number_sheet.dart';
import 'bottom_sheet_service.dart';
import 'launcher_service.dart';
import 'snackbar_service.dart';

/// One way to call a number everywhere: the dialler on phones, and on web
/// and desktop the number shown large with copy and a `tel:` link.
class PhoneCallService {
  PhoneCallService(this._launcher, this._sheets, this._snackbar);

  final LauncherService _launcher;
  final BottomSheetService _sheets;
  final SnackbarService _snackbar;

  /// Returns true if the dialler opened or the number was shown.
  Future<bool> callNumber({
    required String number,
    required String title,
    String? message,
  }) async {
    if (_launcher.canDialDirectly && await _launcher.call(number)) return true;
    await _sheets.show<void>(
      CallNumberSheet(
        title: title,
        number: number,
        message: message,
        onCopy: () async {
          await _launcher.copy(number);
          _snackbar.success(message: 'Number copied');
        },
        onDial: () async {
          if (!await _launcher.call(number)) {
            _snackbar.info(message: 'No phone app found. Dial the number.');
          }
        },
      ),
    );
    return true;
  }
}
