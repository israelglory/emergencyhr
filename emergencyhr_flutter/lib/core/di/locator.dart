import 'package:emergencyhr_flutter/core/services/image_services.dart';
import 'package:emergencyhr_flutter/core/services/snackbar_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/app_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/auth_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/branch_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/customer_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/expense_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/invoice_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/report_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/local/user_management_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/auth_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/branch_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/customer_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/expense_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/invoice_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/report_api.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/user_api.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/auth_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/customer_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/expense_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/invoice_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/report_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/user_repo.dart';
import 'package:get_it/get_it.dart';

import '../cores.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<AuthenticationDataProvider>(
    () => AuthenticationDataProvider(),
  );
  locator.registerLazySingleton<CustomerDataProvider>(
    () => CustomerDataProvider(),
  );
  locator.registerLazySingleton<BranchDataProvider>(() => BranchDataProvider());
  locator.registerLazySingleton<UserDataProvider>(() => UserDataProvider());
  locator.registerLazySingleton<InvoiceDataProvider>(
    () => InvoiceDataProvider(),
  );
  locator.registerLazySingleton<ReportDataProvider>(() => ReportDataProvider());
  locator.registerLazySingleton<ExpenseDataProvider>(
    () => ExpenseDataProvider(),
  );

  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator.registerLazySingleton<BottomSheetService>(() => BottomSheetService());
  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  //STORAGES
  locator.registerLazySingleton(() => AuthLocalStorage());
  locator.registerLazySingleton(() => AppLocalStorage());
  locator.registerLazySingleton(() => InvoiceLocalStorage());
  locator.registerLazySingleton(() => CustomerLocalStorage());
  locator.registerLazySingleton(() => BranchLocalStorage());
  locator.registerLazySingleton(() => UserManagementLocalStorage());
  locator.registerLazySingleton(() => ReportLocalStorage());
  locator.registerLazySingleton(() => ExpenseLocalStorage());

  //GLOBALS
  locator.registerLazySingleton(() => AppGlobals.instance);

  //REPOS
  locator.registerLazySingleton(() => AuthRepo());
  locator.registerLazySingleton(() => CustomerRepo());
  locator.registerLazySingleton(() => BranchRepo());
  locator.registerLazySingleton(() => UserRepo());
  locator.registerLazySingleton(() => InvoiceRepo());
  locator.registerLazySingleton(() => ReportRepo());
  locator.registerLazySingleton(() => ExpenseRepo());
}

//GLOBALS
AppGlobals appGlobals = locator.get<AppGlobals>();

NavigationService navigationService = locator.get<NavigationService>();
SnackbarService snackbarService = locator.get<SnackbarService>();
BottomSheetService bottomSheetService = locator.get<BottomSheetService>();
ImagePickerService imageService = locator.get<ImagePickerService>();

//STORAGES
AuthLocalStorage authLocalStorage = locator.get<AuthLocalStorage>();
AppLocalStorage appLocalStorage = locator.get<AppLocalStorage>();
InvoiceLocalStorage invoiceLocalStorage = locator.get<InvoiceLocalStorage>();
CustomerLocalStorage customerLocalStorage = locator.get<CustomerLocalStorage>();
BranchLocalStorage branchLocalStorage = locator.get<BranchLocalStorage>();
UserManagementLocalStorage userManagementLocalStorage = locator
    .get<UserManagementLocalStorage>();
ReportLocalStorage reportLocalStorage = locator.get<ReportLocalStorage>();
ExpenseLocalStorage expenseLocalStorage = locator.get<ExpenseLocalStorage>();

//REPOS
AuthRepo authRepo = locator.get<AuthRepo>();
CustomerRepo customerRepo = locator.get<CustomerRepo>();
BranchRepo branchRepo = locator.get<BranchRepo>();
UserRepo userRepo = locator.get<UserRepo>();
InvoiceRepo invoiceRepo = locator.get<InvoiceRepo>();
ReportRepo reportRepo = locator.get<ReportRepo>();
ExpenseRepo expenseRepo = locator.get<ExpenseRepo>();
