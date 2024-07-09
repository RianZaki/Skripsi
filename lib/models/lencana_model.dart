class LencanaModel {
  int id;
  String name;
  int targetPoint;

  LencanaModel(
      {required this.id, required this.name, required this.targetPoint});

  factory LencanaModel.fromJson(Map<String, dynamic> json) => LencanaModel(
      id: json["id"],
      name: json["name"] ?? "",
      targetPoint: json["target_point"] ?? 0);
}
