import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';

class NotFoundViewModel extends BaseViewModel {
  NotFoundViewModel({NavigationService? navigation})
    : _navigation = navigation ?? navigationService;

  final NavigationService _navigation;

  static const title = 'Page not found';
  static const message = 'This page does not exist or has moved.';

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);
}
