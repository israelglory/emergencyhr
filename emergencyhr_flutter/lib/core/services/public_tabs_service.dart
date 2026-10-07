import 'package:stacked/stacked.dart';

import '../routes/app_routes.dart';

/// Bottom tabs of the public app. Hidden inside the emergency flow.
enum PublicTab {
  home(AppRoutes.home),
  assistant(AppRoutes.assistant),
  profile(AppRoutes.profile);

  const PublicTab(this.path);
  final String path;
}

/// Which public tab is showing, so any screen (e.g. Home's Quick help) can
/// switch tabs.
class PublicTabsService with ListenableServiceMixin {
  PublicTab _tab = PublicTab.home;

  PublicTab get tab => _tab;

  void select(PublicTab tab) {
    if (_tab == tab) return;
    _tab = tab;
    notifyListeners();
  }
}
