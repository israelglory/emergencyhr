class SignUpParam {
  final String fullName;
  final String email;
  final String password;
  final String businessName;
  final String phone;
  final List<BranchParam> branches;
  final BankDetailsParam? bankDetails;

  SignUpParam({
    required this.fullName,
    required this.email,
    required this.password,
    required this.businessName,
    required this.phone,
    required this.branches,
    this.bankDetails,
  });

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
        "businessName": businessName,
        "phone": phone,
        "branches": branches.map((b) => b.toJson()).toList(),
        if (bankDetails != null) "bankDetails": bankDetails!.toJson(),
      };

  factory SignUpParam.fromJson(Map<String, dynamic> json) => SignUpParam(
        fullName: json["fullName"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        businessName: json["businessName"] ?? '',
        phone: json["phone"] ?? '',
        branches: (json["branches"] as List<dynamic>?)
                ?.map((e) => BranchParam.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        bankDetails: json["bankDetails"] != null
            ? BankDetailsParam.fromJson(
                json["bankDetails"] as Map<String, dynamic>)
            : null,
      );
}

class BranchParam {
  final String name;
  final String address;
  final String phone;
  final bool isMainBranch;

  BranchParam({
    required this.name,
    required this.address,
    required this.phone,
    this.isMainBranch = false,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "isMainBranch": isMainBranch,
      };

  factory BranchParam.fromJson(Map<String, dynamic> json) => BranchParam(
        name: json["name"] ?? '',
        address: json["address"] ?? '',
        phone: json["phone"] ?? '',
        isMainBranch: json["isMainBranch"] ?? false,
      );

  BranchParam copyWith({
    String? name,
    String? address,
    String? phone,
    bool? isMainBranch,
  }) {
    return BranchParam(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      isMainBranch: isMainBranch ?? this.isMainBranch,
    );
  }
}

class BankDetailsParam {
  final String bankName;
  final String accountNumber;
  final String accountName;

  BankDetailsParam({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName,
      };

  factory BankDetailsParam.fromJson(Map<String, dynamic> json) =>
      BankDetailsParam(
        bankName: json["bankName"] ?? '',
        accountNumber: json["accountNumber"] ?? '',
        accountName: json["accountName"] ?? '',
      );

  BankDetailsParam copyWith({
    String? bankName,
    String? accountNumber,
    String? accountName,
  }) {
    return BankDetailsParam(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }
}
