import 'branch_model.dart';

class UserBankDetails {
  final String bankName;
  final String accountNumber;
  final String accountName;

  UserBankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName,
      };

  factory UserBankDetails.fromJson(Map<String, dynamic> json) =>
      UserBankDetails(
        bankName: json["bankName"]?.toString() ?? '',
        accountNumber: json["accountNumber"]?.toString() ?? '',
        accountName: json["accountName"]?.toString() ?? '',
      );

  UserBankDetails copyWith({
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) {
    return UserBankDetails(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }
}

class User {
  final String id;
  final String? businessId;
  final String? businessName;
  final String fullName;
  final String email;
  final String? role;
  final bool isActive;
  final UserBranch? branch;
  final List<UserBranch> branches;
  final UserBankDetails? bankDetails;

  User({
    required this.id,
    this.businessId,
    this.businessName,
    required this.fullName,
    required this.email,
    this.role,
    this.isActive = true,
    this.branch,
    this.branches = const [],
    this.bankDetails,
  });

  String get name => fullName;

  bool get isAdmin =>
      role?.toUpperCase() == 'ROLE_ADMIN' ||
      role?.toUpperCase() == 'ADMIN' ||
      role == null;

  bool get isStaff =>
      role?.toUpperCase() == 'ROLE_STAFF' || role?.toUpperCase() == 'STAFF';

  bool get isSaleBoy =>
      role?.toUpperCase() == 'ROLE_SALE_BOY' ||
      role?.toUpperCase() == 'ROLE_SALES_BOY' ||
      role?.toUpperCase() == 'SALE_BOY' ||
      role?.toUpperCase() == 'SALES_BOY';

  bool get canCreate => true;
  bool get canEdit => isAdmin;
  bool get canDelete => isAdmin;
  bool get canViewFinancialReports => isAdmin || isStaff;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"]?.toString() ?? '',
        businessId: json["businessId"]?.toString(),
        businessName: json["businessName"]?.toString(),
        fullName: json["fullName"]?.toString() ?? json["name"]?.toString() ?? '',
        email: json["email"]?.toString() ?? '',
        role: json["role"]?.toString(),
        isActive: json["isActive"] ?? true,
        branch: json["branch"] != null
            ? UserBranch.fromJson(json["branch"] as Map<String, dynamic>)
            : null,
        branches: (json["branches"] as List<dynamic>?)
                ?.map((e) => UserBranch.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        bankDetails: json["bankDetails"] != null
            ? UserBankDetails.fromJson(
                json["bankDetails"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "businessId": businessId,
        "businessName": businessName,
        "fullName": fullName,
        "name": fullName,
        "email": email,
        "role": role,
        "isActive": isActive,
        if (branch != null) "branch": branch!.toJson(),
        "branches": branches.map((b) => b.toJson()).toList(),
        if (bankDetails != null) "bankDetails": bankDetails!.toJson(),
      };

  User copyWith({
    String? id,
    String? businessId,
    String? businessName,
    String? fullName,
    String? email,
    String? role,
    bool? isActive,
    UserBranch? branch,
    List<UserBranch>? branches,
    UserBankDetails? bankDetails,
  }) {
    return User(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      branch: branch ?? this.branch,
      branches: branches ?? this.branches,
      bankDetails: bankDetails ?? this.bankDetails,
    );
  }
}
