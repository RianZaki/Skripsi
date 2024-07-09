class HistoryPoinModel {
  String idTransaction;
  String createdAt;
  int point;
  String? timeTransaction;
  String? typeTransaction;
  String? phone;
  String? status;
  String? voucher;
  String? missionId;
  String? title;

  HistoryPoinModel(
      {required this.idTransaction,
      required this.createdAt,
      required this.point,
      this.timeTransaction,
      this.typeTransaction,
      this.phone,
      this.status,
      this.voucher,
      this.missionId,
      this.title});

  factory HistoryPoinModel.fromJson(Map<String, dynamic> json) =>
      HistoryPoinModel(
          idTransaction: json["id_transaction"] ?? "",
          createdAt: json["created_at"] ?? "",
          point: json["points"] ?? 0,
          timeTransaction: json["time_transaction"],
          typeTransaction: json["type_transaction"],
          phone: json["phone"],
          status: json["status"],
          voucher: json["voucher"],
          missionId: json["mission_id"],
          title: json["title"]);
}
