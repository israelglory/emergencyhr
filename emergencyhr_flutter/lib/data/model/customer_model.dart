class Customer {
  final String id;
  final String? businessId;
  final String? branchId;
  final String name;
  final String address;
  final String phone;

  Customer({
    required this.id,
    this.businessId,
    this.branchId,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"]?.toString() ?? '',
        businessId: json["businessId"]?.toString(),
        branchId: json["branchId"]?.toString(),
        name: json["name"]?.toString() ?? '',
        address: json["address"]?.toString() ?? '',
        phone: json["phone"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        if (businessId != null) "businessId": businessId,
        if (branchId != null) "branchId": branchId,
        "name": name,
        "address": address,
        "phone": phone,
      };

  Customer copyWith({
    String? id,
    String? businessId,
    String? branchId,
    String? name,
    String? address,
    String? phone,
  }) {
    return Customer(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }
}

class CreateCustomerParam {
  final String? branchId;
  final String name;
  final String address;
  final String phone;

  CreateCustomerParam({
    this.branchId,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory CreateCustomerParam.fromJson(Map<String, dynamic> json) =>
      CreateCustomerParam(
        branchId: json["branchId"]?.toString(),
        name: json["name"]?.toString() ?? '',
        address: json["address"]?.toString() ?? '',
        phone: json["phone"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        if (branchId != null && branchId!.isNotEmpty) "branchId": branchId,
        "name": name,
        "address": address,
        "phone": phone,
      };
}
