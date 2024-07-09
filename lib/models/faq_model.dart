class FaqModel {
  int id;
  String title;
  String desc;

  FaqModel({required this.id, required this.title, required this.desc});
  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      FaqModel(id: json["Id"], title: json["Title"], desc: json["Description"]);

  Map<String, dynamic> toJson() =>
      {"Id": id, "Title": title, "Description": desc};
}
