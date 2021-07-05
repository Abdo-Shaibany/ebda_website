import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.categories,
  });

  List<Category> categories;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.adminId,
    this.parentId,
    this.categoryNameAr,
    this.categoryNameEn,
    this.categorySlugAr,
    this.categorySlugEn,
    this.sorting,
    this.metaTitleAr,
    this.metaTitleEn,
    this.metaKeywordsAr,
    this.metaKeywordsEn,
    this.metaDescriptionAr,
    this.metaDescriptionEn,
    this.publicationStatusAr,
    this.publicationStatusEn,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String adminId;
  String parentId;
  String categoryNameAr;
  String categoryNameEn;
  String categorySlugAr;
  String categorySlugEn;
  String sorting;
  String metaTitleAr;
  String metaTitleEn;
  String metaKeywordsAr;
  String metaKeywordsEn;
  String metaDescriptionAr;
  String metaDescriptionEn;
  String publicationStatusAr;
  String publicationStatusEn;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        adminId: json["admin_id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        categoryNameAr: json["category_name_ar"],
        categoryNameEn: json["category_name_en"],
        categorySlugAr: json["category_slug_ar"],
        categorySlugEn: json["category_slug_en"],
        sorting: json["sorting"],
        metaTitleAr: json["meta_title_ar"],
        metaTitleEn: json["meta_title_en"],
        metaKeywordsAr: json["meta_keywords_ar"],
        metaKeywordsEn: json["meta_keywords_en"],
        metaDescriptionAr: json["meta_description_ar"],
        metaDescriptionEn: json["meta_description_en"],
        publicationStatusAr: json["publication_status_ar"],
        publicationStatusEn: json["publication_status_en"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "parent_id": parentId == null ? null : parentId,
        "category_name_ar": categoryNameAr,
        "category_name_en": categoryNameEn,
        "category_slug_ar": categorySlugAr,
        "category_slug_en": categorySlugEn,
        "sorting": sorting,
        "meta_title_ar": metaTitleAr,
        "meta_title_en": metaTitleEn,
        "meta_keywords_ar": metaKeywordsAr,
        "meta_keywords_en": metaKeywordsEn,
        "meta_description_ar": metaDescriptionAr,
        "meta_description_en": metaDescriptionEn,
        "publication_status_ar": publicationStatusAr,
        "publication_status_en": publicationStatusEn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
