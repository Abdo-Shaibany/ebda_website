// To parse this JSON data, do
//
//     final MainJournals = MainJournalsFromJson(jsonString);

import 'dart:convert';

MainJournals mainJournalsFromJson(String str) =>
    MainJournals.fromJson(json.decode(str));

String mainJournalsToJson(MainJournals data) => json.encode(data.toJson());

class MainJournals {
  MainJournals({
    this.data,
  });

  Data data;

  factory MainJournals.fromJson(Map<String, dynamic> json) => MainJournals(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
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
  List<Journal> data;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Journal>.from(json["data"].map((x) => Journal.fromJson(x))),
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

class Journal {
  Journal({
    this.id,
    this.lang,
    this.pageName,
    this.pageFeaturedImage,
    this.publicationStatus,
    this.createdAt,
    this.updatedAt,
    this.verNumber,
    this.viewCount,
    this.downloadCount,
    this.verDate,
    this.pdfFile,
    this.fullImageUrl,
    this.fullPdfUrl,
  });

  int id;
  String lang;
  String pageName;
  String pageFeaturedImage;
  String publicationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String verNumber;
  String viewCount;
  String downloadCount;
  DateTime verDate;
  String pdfFile;
  String fullImageUrl;
  String fullPdfUrl;

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        id: json["id"],
        lang: json["lang"],
        pageName: json["page_name"],
        pageFeaturedImage: json["page_featured_image"],
        publicationStatus: json["publication_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        verNumber: json["ver_number"],
        viewCount: json["view_count"],
        downloadCount: json["download_count"],
        verDate: DateTime.parse(json["ver_date"]),
        pdfFile: json["pdf_file"],
        fullImageUrl: json["full_image_url"],
        fullPdfUrl: json["full_pdf_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "page_name": pageName,
        "page_featured_image": pageFeaturedImage,
        "publication_status": publicationStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ver_number": verNumber,
        "view_count": viewCount,
        "download_count": downloadCount,
        "ver_date":
            "${verDate.year.toString().padLeft(4, '0')}-${verDate.month.toString().padLeft(2, '0')}-${verDate.day.toString().padLeft(2, '0')}",
        "pdf_file": pdfFile,
        "full_image_url": fullImageUrl,
        "full_pdf_url": fullPdfUrl,
      };
}
