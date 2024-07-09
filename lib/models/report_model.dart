class ReportModel {
  String id;
  String reportType;
  num? longitude;
  num? latitude;
  String? location;
  String? desc;
  String? addressPoint;
  String? status;
  List<ImageModel>? image;
  String? scaleType;
  String? insidentDate;
  String? insidentTime;
  String? trashType;
  bool? dangerousWaste;
  String? companyName;
  DateTime? createAt;
  DateTime? updateAt;

  ReportModel(
      {required this.id,
      required this.reportType,
      this.longitude,
      this.latitude,
      this.location,
      this.desc,
      this.addressPoint,
      this.status,
      this.image,
      this.scaleType,
      this.insidentDate,
      this.insidentTime,
      this.dangerousWaste,
      this.companyName,
      this.trashType,
      this.createAt,
      this.updateAt});
  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
      id: json["Id"] ?? "",
      reportType: json["report_type"] ?? "",
      longitude: json["longitude"] ?? 0,
      latitude: json["latitude"] ?? 0,
      location: json["location"] ?? "",
      desc: json["description"] ?? "",
      addressPoint: json["address_point"] ?? "",
      status: json["status"] ?? "",
      image: json["images"] == null
          ? []
          : List<ImageModel>.from(
              json["images"]!.map((x) => ImageModel.fromJson(x))),
      scaleType: json["scale_type"] ?? "",
      insidentDate: json["insident_date"] ?? "",
      insidentTime: json["insident_time"] ?? "",
      dangerousWaste: json["dangerous_waste"] ?? false,
      companyName: json["company_name"] ?? "",
      trashType: json["trash_type"] ?? "",
      createAt: DateTime.parse(json["created_at"]),
      updateAt: DateTime.parse(json["updated_at"]));
  Map<String, dynamic> toJson() => {
        "Id": id,
        "report_type": reportType,
        "longitude": longitude,
        "latitude": latitude,
        "location": location,
        "description": desc,
        "address_point": addressPoint,
        "status": status,
        "images": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
        "scale_type": scaleType,
        "insident_date": insidentDate,
        "insident_time": insidentTime,
        "company_name": companyName,
        "dangerous_waste": dangerousWaste
      };
}

class ImageModel {
  String? id;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  ImageModel({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
