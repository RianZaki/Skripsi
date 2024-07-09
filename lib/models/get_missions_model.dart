class GetMissionsModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetMissionsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetMissionsModel.fromJson(Map<String, dynamic> json) =>
      GetMissionsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );
}

class Data {
  String? missionId;
  String? claimedId;
  String? title;
  String? statusMission;
  String? missionImage;
  String? reason;
  int? point;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? titleStage;
  String? descriptionStage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? transactionId;
  String? statusApproval;

  Data({
    this.missionId,
    this.claimedId,
    this.title,
    this.statusMission,
    this.missionImage,
    this.reason,
    this.point,
    this.description,
    this.startDate,
    this.endDate,
    this.titleStage,
    this.descriptionStage,
    this.createdAt,
    this.updatedAt,
    this.transactionId,
    this.statusApproval,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        missionId: json["mission_id"],
        claimedId: json["claimed_id"],
        title: json["title"],
        statusMission:
            json["status_mission"] == null ? null : json["status_mission"],
        missionImage: json["mission_image"],
        reason: json["reason"] == null ? null : json["reason"],
        point: json["point"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        titleStage: json["title_stage"],
        descriptionStage: json["description_stage"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        transactionId: json["transaction_id"],
        statusApproval: json["status_approval"],
      );
}
