// class ProfileModel {
//   final String name;
//   final String email;
//   final String phone;
//   final String dateOfBirth;
//   final String? gender;
//   final String address;
//   final String? avatarUrl;

//   const ProfileModel({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.address,
//     this.avatarUrl,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       name: json['name']?.toString() ?? '',
//       email: json['email']?.toString() ?? '',
//       phone: json['phone']?.toString() ?? '',
//       dateOfBirth: json['date_of_birth']?.toString() ?? '',
//       gender: json['gender']?.toString(),
//       address: json['address']?.toString() ?? '',
//       avatarUrl: (json['avatar_url'] ?? json['avatar'])?.toString(),
//     );
//   }

//   Null get data => null;

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'date_of_birth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//     };
//   }

//   ProfileModel copyWith({
//     String? name,
//     String? email,
//     String? phone,
//     String? dateOfBirth,
//     String? gender,
//     String? address,
//     String? avatarUrl,
//   }) {
//     return ProfileModel(
//       name: name ?? this.name,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//       address: address ?? this.address,
//       avatarUrl: avatarUrl ?? this.avatarUrl,
//     );
//   }
// }

class UpdateProfileModel {
  UpdateProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
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
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final String? phone;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      phone: json["phone"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
