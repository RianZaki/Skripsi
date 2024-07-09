class CategoryModel {
  String category;

  CategoryModel({
    required this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
      };

      static String getCategoryStringList(List<CategoryModel> categories) {
    return categories.map((category) => category.category).join(', ');
  }
}