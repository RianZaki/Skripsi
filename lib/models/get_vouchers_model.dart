class GetVouchersModel {
  String id;
  String image;
  String rewardName;
  int point;
  String description;
  DateTime startDate;
  DateTime endDate;

  GetVouchersModel({
    required this.id,
    required this.image,
    required this.rewardName,
    required this.point,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory GetVouchersModel.fromJson(Map<String, dynamic> json) => GetVouchersModel(
        id: json["id"],
        image: json["image"],
        rewardName: json["reward_name"],
        point: json["point"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );
}
