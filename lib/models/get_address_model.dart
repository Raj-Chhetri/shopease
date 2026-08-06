class GetAddressModel {
  GetAddressModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory GetAddressModel.fromJson(Map<String, dynamic> json) {
    return GetAddressModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.isDefault,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final bool? isDefault;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: _toInt(json["id"]),
      userId: _toInt(json["user_id"]),
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      city: json["city"],
      state: json["state"],
      zipCode: json["zip_code"],
      country: json["country"],
      isDefault: _toBool(json["is_default"]),
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "country": country,
    "is_default": isDefault,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static bool? _toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;

    switch (value.toString().trim().toLowerCase()) {
      case 'true':
      case '1':
        return true;
      case 'false':
      case '0':
        return false;
      default:
        return null;
    }
  }
}

Datum? selectCurrentDeliveryAddress(Iterable<Datum> addresses) {
  final availableAddresses = addresses
      .where((address) => address.id != null && address.deletedAt == null)
      .toList();

  if (availableAddresses.isEmpty) return null;

  availableAddresses.sort((left, right) {
    final leftDate = left.updatedAt ?? left.createdAt ?? DateTime(1970);
    final rightDate = right.updatedAt ?? right.createdAt ?? DateTime(1970);
    final dateComparison = rightDate.compareTo(leftDate);

    if (dateComparison != 0) return dateComparison;
    return (right.id ?? 0).compareTo(left.id ?? 0);
  });

  return availableAddresses.first;
}
