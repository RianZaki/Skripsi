class EventsModel {
  String? id;
  String? communityId;
  String? title;
  String? image;
  String? description;
  String? location;
  String? maplink;
  String? formlink;
  int? quota;
  String? date;
  String? status;

  EventsModel({
    this.id,
    this.communityId,
    this.title,
    this.image,
    this.description,
    this.location,
    this.maplink,
    this.formlink,
    this.quota,
    this.date,
    this.status,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["id"],
        communityId: json["communityId"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        location: json["location"],
        maplink: json["maplink"],
        formlink: json["formlink"],
        quota: json["quota"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "communityId": communityId,
        "title": title,
        "image": image,
        "description": description,
        "location": location,
        "maplink": maplink,
        "formlink": formlink,
        "quota": quota,
        "date": date,
        "status": status,
      };
}
