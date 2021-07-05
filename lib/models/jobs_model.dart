// To parse this JSON data, do
//
//     final MainJobs = MainJobsFromJson(jsonString);

import 'dart:convert';

MainJobs mainJobsFromJson(String str) => MainJobs.fromJson(json.decode(str));

String mainJobsToJson(MainJobs data) => json.encode(data.toJson());

class MainJobs {
  MainJobs({
    this.data,
  });

  Data data;

  factory MainJobs.fromJson(Map<String, dynamic> json) => MainJobs(
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
  List<Job> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Job>.from(json["data"].map((x) => Job.fromJson(x))),
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

class Job {
  Job({
    this.id,
    this.jobTitle,
    this.createdAt,
    this.jobCity,
    this.jobShortDesc,
    this.jobDeadlineDate,
    this.nameCompany,
  });

  String id;
  String jobTitle;
  DateTime createdAt;
  String jobCity;
  String jobShortDesc;
  DateTime jobDeadlineDate;
  String nameCompany;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        jobTitle: json["job_title"],
        createdAt: DateTime.parse(json["created_at"]),
        jobCity: json["job_city"],
        jobShortDesc: json["job_short_desc"],
        jobDeadlineDate: DateTime.parse(json["job_deadline_date"]),
        nameCompany: json["name_company"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_title": jobTitle,
        "created_at": createdAt.toIso8601String(),
        "job_city": jobCity,
        "job_short_desc": jobShortDesc,
        "job_deadline_date":
            "${jobDeadlineDate.year.toString().padLeft(4, '0')}-${jobDeadlineDate.month.toString().padLeft(2, '0')}-${jobDeadlineDate.day.toString().padLeft(2, '0')}",
        "name_company": nameCompany,
      };
}
