class ChangePasswordModel {
    ChangePasswordModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final dynamic data;

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json){ 
        return ChangePasswordModel(
            success: json["success"],
            message: json["message"],
            data: json["data"],
        );
    }

}
