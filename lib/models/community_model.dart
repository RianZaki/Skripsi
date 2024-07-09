// To parse this JSON data, do
//
//     final communityModel = communityModelFromJson(jsonString);

import 'dart:convert';

CommunityModel communityModelFromJson(String str) =>
    CommunityModel.fromJson(json.decode(str));

String communityModelToJson(CommunityModel data) => json.encode(data.toJson());

class CommunityModel {
  String? id;
  String? name;
  String? description;
  String? location;
  int? maxMembers;
  String? image;
  DateTime? createdAt;

  CommunityModel({
    this.id,
    this.name,
    this.description,
    this.location,
    this.maxMembers,
    this.image,
    this.createdAt,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        maxMembers: json["max_members"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "location": location,
        "max_members": maxMembers,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
