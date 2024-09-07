// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

import 'login_model.dart';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.notfications,
    this.user,
    this.companyWhatsapp,
    this.companyPhone,
    this.companyLocation,
    this.membershipLevel,
  });

  String? status;
  List<Notfication>? notfications;
  User? user;
  String? companyWhatsapp;
  String? companyPhone;
  String? companyLocation;
  String? membershipLevel;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    status: json["status"],
    notfications: List<Notfication>.from(json["notfications"].map((x) => Notfication.fromJson(x))),
    user: User.fromJson(json["user"]),
    companyWhatsapp: json["company_whatsapp"],
    companyPhone: json["company_phone"],
    companyLocation: json["company_location"],
    membershipLevel: json["membership_level"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notfications": List<dynamic>.from(notfications!.map((x) => x.toJson())),
    "user": user!.toJson(),
    "company_whatsapp": companyWhatsapp,
    "company_phone": companyPhone,
    "company_location": companyLocation,
    "membership_level": membershipLevel,
  };
}

class Notfication {
  Notfication({
    this.title,
    this.message,
  });

  String? title;
  String? message;

  factory Notfication.fromJson(Map<String, dynamic> json) => Notfication(
    title: json["title"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
  };
}
