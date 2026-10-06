class Branch {
  final String id;
  final String? businessId;
  final String name;
  final String address;
  final String phone;
  final bool isMainBranch;

  Branch({
    required this.id,
    this.businessId,
    required this.name,
    required this.address,
    required this.phone,
    this.isMainBranch = false,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"]?.toString() ?? '',
        businessId: json["businessId"]?.toString(),
        name: json["name"]?.toString() ?? '',
        address: json["address"]?.toString() ?? '',
        phone: json["phone"]?.toString() ?? '',
        isMainBranch: json["isMainBranch"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        if (businessId != null) "businessId": businessId,
        "name": name,
        "address": address,
        "phone": phone,
        "isMainBranch": isMainBranch,
      };

  Branch copyWith({
    String? id,
    String? businessId,
    String? name,
    String? address,
    String? phone,
    bool? isMainBranch,
  }) {
    return Branch(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      isMainBranch: isMainBranch ?? this.isMainBranch,
    );
  }
}

typedef UserBranch = Branch;

class CreateBranchParam {
  final String name;
  final String address;
  final String phone;
  final bool isMainBranch;

  CreateBranchParam({
    required this.name,
    required this.address,
    required this.phone,
    this.isMainBranch = false,
  });

  factory CreateBranchParam.fromJson(Map<String, dynamic> json) =>
      CreateBranchParam(
        name: json["name"]?.toString() ?? '',
        address: json["address"]?.toString() ?? '',
        phone: json["phone"]?.toString() ?? '',
        isMainBranch: json["isMainBranch"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "isMainBranch": isMainBranch,
      };
}
