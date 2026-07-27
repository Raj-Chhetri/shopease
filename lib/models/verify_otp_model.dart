class VerifyOtp {
    VerifyOtp({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final dynamic data;

    factory VerifyOtp.fromJson(Map<String, dynamic> json){ 
        return VerifyOtp(
            success: json["success"],
            message: json["message"],
            data: json["data"],
        );
    }

}
