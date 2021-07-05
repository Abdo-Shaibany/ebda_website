// To parse this JSON data, do
//
//     final MainPosts = MainPostsFromJson(jsonString);

import 'dart:convert';

MainPosts mainPostsFromJson(String str) => MainPosts.fromJson(json.decode(str));

String mainPostsToJson(MainPosts data) => json.encode(data.toJson());

class MainPosts {
  MainPosts({
    this.posts,
  });

  Posts posts;

  factory MainPosts.fromJson(Map<String, dynamic> json) => MainPosts(
        posts: Posts.fromJson(json["posts"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts.toJson(),
      };
}

class Posts {
  Posts({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Post> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        currentPage: json["current_page"],
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Post {
  Post({
    this.id,
    this.postDateAr,
    this.postDateEn,
    this.postTitleAr,
    this.postTitleEn,
    this.shortPostDetailsAr,
    this.shortPostDetailsEn,
    this.inNews,
    this.featuredImageAr,
    this.featuredImageEn,
    this.publicationStatusAr,
    this.publicationStatusEn,
    this.viewCountAr,
    this.viewCountEn,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  DateTime postDateAr;
  DateTime postDateEn;
  String postTitleAr;
  dynamic postTitleEn;
  String shortPostDetailsAr;
  String shortPostDetailsEn;
  String inNews;
  String featuredImageAr;
  String featuredImageEn;
  String publicationStatusAr;
  String publicationStatusEn;
  String viewCountAr;
  String viewCountEn;
  DateTime createdAt;
  DateTime updatedAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        postDateAr: DateTime.parse(json["post_date_ar"]),
        postDateEn: DateTime.parse(json["post_date_en"]),
        postTitleAr: json["post_title_ar"],
        postTitleEn: json["post_title_en"],
        shortPostDetailsAr: json["short_post_details_ar"],
        shortPostDetailsEn: json["short_post_details_en"],
        inNews: json["in_news"],
        featuredImageAr: json["featured_image_ar"],
        featuredImageEn: json["featured_image_en"],
        publicationStatusAr: json["publication_status_ar"],
        publicationStatusEn: json["publication_status_en"],
        viewCountAr: json["view_count_ar"],
        viewCountEn: json["view_count_en"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_date_ar": postDateAr.toIso8601String(),
        "post_date_en":
            "${postDateEn.year.toString().padLeft(4, '0')}-${postDateEn.month.toString().padLeft(2, '0')}-${postDateEn.day.toString().padLeft(2, '0')}",
        "post_title_ar": postTitleAr,
        "post_title_en": postTitleEn,
        "short_post_details_ar": shortPostDetailsAr,
        "short_post_details_en": shortPostDetailsEn,
        "in_news": inNews,
        "featured_image_ar": featuredImageAr,
        "featured_image_en": featuredImageEn,
        "publication_status_ar": publicationStatusAr,
        "publication_status_en": publicationStatusEn,
        "view_count_ar": viewCountAr,
        "view_count_en": viewCountEn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
