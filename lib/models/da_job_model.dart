// To parse this JSON data, do
//
//     final MainJob = MainJobFromJson(jsonString);

import 'dart:convert';

MainJob mainJobFromJson(String str) => MainJob.fromJson(json.decode(str));

String mainJobToJson(MainJob data) => json.encode(data.toJson());

class MainJob {
  MainJob({
    this.data,
  });

  DaJob data;

  factory MainJob.fromJson(Map<String, dynamic> json) => MainJob(
        data: DaJob.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DaJob {
  DaJob({
    this.id,
    this.idCompany,
    this.nameCompany,
    this.descCompany,
    this.jobTitle,
    this.jobSlugTitle,
    this.jobShortDesc,
    this.jobDesc,
    this.jobCity,
    this.email,
    this.phone,
    this.jobDeadlineDate,
    this.userId,
    this.adminId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String idCompany;
  String nameCompany;
  String descCompany;
  String jobTitle;
  String jobSlugTitle;
  String jobShortDesc;
  String jobDesc;
  String jobCity;
  String email;
  dynamic phone;
  DateTime jobDeadlineDate;
  dynamic userId;
  String adminId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory DaJob.fromJson(Map<String, dynamic> json) => DaJob(
        id: json["id"],
        idCompany: json["id_company"],
        nameCompany: json["name_company"],
        descCompany: json["desc_company"],
        jobTitle: json["job_title"],
        jobSlugTitle: json["job_slug_title"],
        jobShortDesc: json["job_short_desc"],
        jobDesc: json["job_desc"],
        jobCity: json["job_city"],
        email: json["email"],
        phone: json["phone"],
        jobDeadlineDate: DateTime.parse(json["job_deadline_date"]),
        userId: json["user_id"],
        adminId: json["admin_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_company": idCompany,
        "name_company": nameCompany,
        "desc_company": descCompany,
        "job_title": jobTitle,
        "job_slug_title": jobSlugTitle,
        "job_short_desc": jobShortDesc,
        "job_desc": jobDesc,
        "job_city": jobCity,
        "email": email,
        "phone": phone,
        "job_deadline_date":
            "${jobDeadlineDate.year.toString().padLeft(4, '0')}-${jobDeadlineDate.month.toString().padLeft(2, '0')}-${jobDeadlineDate.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "admin_id": adminId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
