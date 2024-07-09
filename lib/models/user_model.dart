import 'package:recything_mobile/models/community_model.dart';

class UserModel {
  String id;
  String fullname;
  String email;
  String dateOfBirth;
  int point;
  String phone;
  String address;
  String purpose;
  String? badge;
  List<CommunityModel>? communities;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.dateOfBirth,
    required this.point,
    required this.phone,
    required this.address,
    required this.purpose,
    this.badge,
    this.communities,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] ?? "",
      fullname: json["fullname"] ?? "",
      email: json["email"] ?? "",
      dateOfBirth: json["date_of_birth"] ?? "",
      point: json["point"] ?? 0,
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      purpose: json["purpose"] ?? "",
      badge: json["badge"] ?? "",
      communities: json["communities"] == null
          ? []
          : List<CommunityModel>.from(
              json["communities"]!.map((x) => CommunityModel.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "date_of_birth": dateOfBirth,
        "point": point,
        "phone": phone,
        "address": address,
        "purpose": purpose,
        "badge": badge
      };
}
