import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/core/utilities/user_roles.dart';
import 'package:emergencyhr_flutter/data/model/user_model.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform;

class AppGlobals extends ChangeNotifier {
  static AppGlobals instance = AppGlobals._();
  AppGlobals._();

  String? _token;
  String? _refreshToken;
  String? _notificationToken;
  User? _user;
  bool? subscribed;
  String? subscriptionPlan;
  bool? isBiometricEnabled;

  Future<void> init() async {
    _token = authLocalStorage.getToken();
    _refreshToken = authLocalStorage.getRefreshToken();
    _user = appLocalStorage.getUser();

    _notificationToken = appLocalStorage.getNotificationToken();
    isBiometricEnabled = authLocalStorage.getBiometrics();
  }

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  set refreshToken(String? value) {
    _refreshToken = value;
    notifyListeners();
  }

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  set setUser(User? value) {
    _user = value;
    notifyListeners();
  }

  set biometrics(bool? value) {
    isBiometricEnabled = value;
    notifyListeners();
  }

  set isSubscribed(bool? value) {
    subscribed = value;
    notifyListeners();
  }

  set setSubscriptionPlan(String? value) {
    subscriptionPlan = value;
    notifyListeners();
  }

  set notificationToken(String? value) {
    _notificationToken = value;
    notifyListeners();
  }

  String? get token => _token;
  User? get user => _user;

  String? get notificationToken => _notificationToken;
  bool get isSubscribed => subscribed ?? false;
  String? get refreshToken => _refreshToken;
  String? get getSubscriptionPlan => subscriptionPlan;
  void updateUser(User updatedUser) {
    _user = updatedUser;
    appLocalStorage.saveUser(updatedUser);
    notifyListeners();
  }

  void clearAuth() {
    _token = null;
    _refreshToken = null;
    _user = null;
    notifyListeners();
  }

  AppPermissions get permissions => AppPermissions(_user?.role);
  bool get isAdmin => permissions.isAdmin;
  bool get isStaff => permissions.isStaff;
  bool get isSaleBoy => permissions.isSaleBoy;
  bool get canCreate => permissions.canCreate;
  bool get canEdit => permissions.canEdit;
  bool get canDelete => permissions.canDelete;
  bool get canViewFinancialReports => permissions.canViewFinancialReports;
  bool get canManageBranches => permissions.canManageBranches;
  bool get canManageUsers => permissions.canManageUsers;

  bool get isBiometricsEnabled => isBiometricEnabled ?? false;
  bool get isAndroid => Platform.isAndroid;
}
