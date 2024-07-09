class DropModel {
  List<DropPointsModel>? data;
  PaginationModel? pagination;

  DropModel({this.data, this.pagination});
  factory DropModel.fromJson(Map<String, dynamic> json) => DropModel(
      data: json["data"] == null
          ? []
          : List<DropPointsModel>.from(
              json["data"]!.map((x) => DropPointsModel.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : PaginationModel.fromJson(json["pagination"]));
}

class PaginationModel {
  int limit;
  int currentPage;
  int lastPage;

  PaginationModel(
      {required this.limit, required this.currentPage, required this.lastPage});
  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
          limit: json["limit"],
          currentPage: json["current_page"],
          lastPage: json["last_page"]);
}

class DropPointsModel {
  String id;
  String name;
  String address;
  num? latitude;
  num? longitude;
  List<ScheduleModel>? scheduleModel;

  DropPointsModel(
      {required this.id,
      required this.name,
      required this.address,
      this.latitude,
      this.longitude,
      this.scheduleModel});

  factory DropPointsModel.fromJson(Map<String, dynamic> json) =>
      DropPointsModel(
          id: json["id"] ?? "",
          name: json["name"],
          address: json["address"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          scheduleModel: json["schedule"] == null
              ? []
              : List<ScheduleModel>.from(
                  json["schedule"]!.map((x) => ScheduleModel.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "schedul": scheduleModel == null
            ? []
            : List<dynamic>.from(scheduleModel!.map((x) => x.toJson()))
      };
}

class ScheduleModel {
  String day;
  String openTime;
  String closeTime;
  bool? closed;

  ScheduleModel(
      {required this.day,
      required this.openTime,
      required this.closeTime,
      this.closed});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
      day: json["day"] ?? " ",
      openTime: json["open_time"] ?? " ",
      closeTime: json["close_time"] ?? " ",
      closed: json["closed"]);

  Map<String, dynamic> toJson() => {
        "day": day,
        "open_time": openTime,
        "close_time": closeTime,
        "closed": closed
      };
}
