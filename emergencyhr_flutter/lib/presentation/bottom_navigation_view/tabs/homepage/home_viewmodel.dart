import 'package:emergencyhr_flutter/core/constants/app_assets.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  int _currentCarouselIndex = 0;

  int get currentCarouselIndex => _currentCarouselIndex;

  void setCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  List<String> quotes = [
    AppAssets.quote1,
    AppAssets.quote2,
    AppAssets.quote3,
    AppAssets.quote4,
    AppAssets.quote5,
    AppAssets.quote6,
    AppAssets.quote7,
    AppAssets.quote8,
    AppAssets.quote9,
    AppAssets.quote10,
  ];
}
