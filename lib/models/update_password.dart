import 'dart:convert';

UpdatePasswordModel updatePasswordModelFromJson(String str) =>
    UpdatePasswordModel.fromJson(json.decode(str));

String updatePasswordModelToJson(UpdatePasswordModel data) =>
    json.encode(data.toJson());

class UpdatePasswordModel {
  bool status;
  String message;

  UpdatePasswordModel({
    required this.status,
    required this.message,
  });

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
