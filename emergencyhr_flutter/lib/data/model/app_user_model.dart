class AppUser {
  final String id;
  final String? businessId;
  final String? branchId;
  final String fullName;
  final String email;
  final String role;
  final bool isActive;

  AppUser({
    required this.id,
    this.businessId,
    this.branchId,
    required this.fullName,
    required this.email,
    required this.role,
    this.isActive = true,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"]?.toString() ?? '',
        businessId: json["businessId"]?.toString(),
        branchId: json["branchId"]?.toString(),
        fullName: json["fullName"]?.toString() ?? '',
        email: json["email"]?.toString() ?? '',
        role: json["role"]?.toString() ?? 'ROLE_STAFF',
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        if (businessId != null) "businessId": businessId,
        if (branchId != null) "branchId": branchId,
        "fullName": fullName,
        "email": email,
        "role": role,
        "isActive": isActive,
      };

  AppUser copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? fullName,
    String? email,
    String? role,
    bool? isActive,
  }) {
    return AppUser(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }
}

class CreateUserParam {
  final String fullName;
  final String email;
  final String password;
  final String role;
  final String? branchId;

  CreateUserParam({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    this.branchId,
  });

  factory CreateUserParam.fromJson(Map<String, dynamic> json) =>
      CreateUserParam(
        fullName: json["fullName"]?.toString() ?? '',
        email: json["email"]?.toString() ?? '',
        password: json["password"]?.toString() ?? '',
        role: json["role"]?.toString() ?? 'ROLE_STAFF',
        branchId: json["branchId"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
        "role": role,
        if (branchId != null && branchId!.isNotEmpty) "branchId": branchId,
      };
}
