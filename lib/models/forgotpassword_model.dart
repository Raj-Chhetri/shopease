class ForgotPasswordModel {
    ForgotPasswordModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final dynamic data;

    factory ForgotPasswordModel.fromJson(Map<String, dynamic> json){ 
        return ForgotPasswordModel(
            success: json["success"],
            message: json["message"],
            data: json["data"],
        );
    }
}