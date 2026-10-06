class UserRoles {
  static const String roleAdmin = 'ROLE_ADMIN';
  static const String roleStaff = 'ROLE_STAFF';
  static const String roleSaleBoy = 'ROLE_SALE_BOY';
  static const String roleSalesBoy = 'ROLE_SALES_BOY';

  static String getRoleLabel(String? role) {
    switch (role?.toUpperCase()) {
      case roleAdmin:
      case 'ADMIN':
        return 'Administrator';
      case roleStaff:
      case 'STAFF':
        return 'Staff Member';
      case roleSaleBoy:
      case roleSalesBoy:
      case 'SALE_BOY':
      case 'SALES_BOY':
        return 'Sales Representative';
      default:
        return 'Staff';
    }
  }
}

class AppPermissions {
  final String? userRole;

  const AppPermissions(this.userRole);

  String get _normalizedRole => userRole?.toUpperCase() ?? '';

  bool get isAdmin =>
      _normalizedRole == UserRoles.roleAdmin ||
      _normalizedRole == 'ADMIN' ||
      _normalizedRole.isEmpty; // Default to full access if role not yet set

  bool get isStaff =>
      _normalizedRole == UserRoles.roleStaff || _normalizedRole == 'STAFF';

  bool get isSaleBoy =>
      _normalizedRole == UserRoles.roleSaleBoy ||
      _normalizedRole == UserRoles.roleSalesBoy ||
      _normalizedRole == 'SALE_BOY' ||
      _normalizedRole == 'SALES_BOY';

  /// All authenticated roles (ADMIN, STAFF, SALE_BOY) can create resources
  bool get canCreate => true;

  /// Only ADMIN can edit resources (Customers, Invoices, Expenses, Branches, Users)
  bool get canEdit => isAdmin;

  /// Only ADMIN can delete resources
  bool get canDelete => isAdmin;

  /// ADMIN and STAFF can view financial reports (STAFF for their branch, ADMIN for all)
  /// SALE_BOY cannot see financial reports
  bool get canViewFinancialReports => isAdmin || isStaff;

  /// Only ADMIN can manage branches and users
  bool get canManageBranches => isAdmin;
  bool get canManageUsers => isAdmin;
}
