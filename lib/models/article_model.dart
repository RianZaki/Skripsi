import 'package:intl/intl.dart';

import 'category_article_model.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? content;
  List<CategoryModel>? categories;
  int? like;
  int? share;
  String? createdDate;
  String? categoryArticle;

  ArticleModel({
    this.id,
    this.title,
    this.image,
    this.content,
    this.categories,
    this.like,
    this.share,
    this.categoryArticle,
    String? createdDate,
  }) : createdDate = createdDate != null ? _formatDate(createdDate) : "";

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> categoriesList = [];
    if (json["categories"] != null) {
      categoriesList = (json["categories"] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    }

    return ArticleModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      content: json["content"],
      categories: categoriesList,
      like: json["like"],
      share: json["share"],
      createdDate: json["created_at"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "title": title,
  //       "image": image,
  //       "content": content,
  //       "categories": categories.map((category) => category.toJson()).toList(),
  //       "like": like,
  //       "share": share,
  //       "created_at": createdDate,
  //     };

  static String _formatDate(String inputDate) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the date using intl package
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

    return formattedDate;
  }

  String getCategoryString() {
    return CategoryModel.getCategoryStringList(categories ?? []);
  }
}

class SearchFieldItem {
  String title;

  SearchFieldItem({required this.title});
}

// class LikeArticle {
//   bool status;
//   String message;

//   LikeArticle({
//     required this.status,
//     required this.message,
//   });

//   factory LikeArticle.fromJson(Map<String, dynamic> json) {
//     return LikeArticle(
//       status: json["status"],
//       message: json["message"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//       };
// }

// class LikeArticle {
//   final String message;

//   LikeArticle({
//     required this.message,
//   });

//   factory LikeArticle.fromJson(Map<String, dynamic> data) {
//     final String message = data['message'];
//     return LikeArticle(message: message);
//   }
// }
