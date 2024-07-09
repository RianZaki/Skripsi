class DailyPoinModel {
  bool? claim;
  int? dailyPointId;
  DateTime? createdAt;

  DailyPoinModel({
    this.claim,
    this.dailyPointId,
    this.createdAt,
  });

  factory DailyPoinModel.fromJson(Map<String, dynamic> json) => DailyPoinModel(
        claim: json["claim"],
        dailyPointId: json["daily_point_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "claim": claim,
        "daily_point_id": dailyPointId,
        "created_at": createdAt?.toIso8601String(),
      };
}
