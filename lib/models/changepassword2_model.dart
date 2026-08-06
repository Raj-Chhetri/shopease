// TODO Implement this library.
class ChangePassword2Model {
  final bool success;
  final String message;
  final dynamic data;

  ChangePassword2Model({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChangePassword2Model.fromJson(Map<String, dynamic> json) {
    return ChangePassword2Model(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data};
  }
}
