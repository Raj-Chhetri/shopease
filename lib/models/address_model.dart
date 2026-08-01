class CreateAddressModel {
  CreateAddressModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CreateAddressModel.fromJson(Map<String, dynamic> json) {
    return CreateAddressModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final int? userId;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      city: json["city"],
      state: json["state"],
      zipCode: json["zip_code"],
      country: json["country"],
      userId: json["user_id"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "country": country,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
