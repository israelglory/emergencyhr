import '../../data/models/shell_kind.dart';
import '../routes/app_routes.dart';
import 'navigation_service.dart';
import 'session_service.dart';
import 'snackbar_service.dart';

/// Guards the staff shells. Sends guests to sign in and back, and other
/// users home with an explanation. The server enforces access regardless.
class AccessService {
  AccessService(this._session, this._navigation, this._snackbar);

  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  Future<bool> ensure(ShellKind shell, {required String returnTo}) async {
    await _session.ready();
    if (_session.canOpen(shell)) return true;
    if (!_session.isSignedIn) {
      await _navigation.replaceWith<void>(AppRoutes.signInWithNext(returnTo));
    } else {
      _snackbar.error(message: 'Your account does not have access to this.');
      await _navigation.clearStackAndShow<void>(AppRoutes.home);
    }
    return false;
  }
}
