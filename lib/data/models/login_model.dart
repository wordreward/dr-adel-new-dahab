// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.token,
    this.user,
    this.companyWhatsapp,
    this.companyPhone,
    this.companyLocation,
    this.membershipLevel,
    this.referrerMsgEn,
    this.referrerMsgAr,
    this.fReviewPoint,
    this.gReviewPoint,
    this.googleReview
  });

  String? success;
  String? token;
  User? user;
  String? companyWhatsapp;
  String? googleReview;
  String? companyPhone;
  String? referrerMsgEn;
  String? referrerMsgAr;
  String? gReviewPoint;
  String? fReviewPoint;
  String? companyLocation;
  String? membershipLevel;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    token: json["token"],
    user: User.fromJson(json["user"]),
    companyWhatsapp: json["company_whatsapp"],
    referrerMsgEn: json["referrer_msg_en"],
    googleReview: json["google_review"],
    referrerMsgAr: json["referrer_msg_ar"],
    fReviewPoint: json["Facebook Review"],
    gReviewPoint: json["Google Review"],
    companyPhone: json["company_phone"],
    companyLocation: json["company_location"],
    membershipLevel: json["membership_level"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "user": user!.toJson(),
    "company_whatsapp": companyWhatsapp,
    "Facebook Review": fReviewPoint,
    "google_review": googleReview,
    "Google Review": gReviewPoint,
    "company_phone": companyPhone,
    "referrer_msg_en": referrerMsgEn,
    "referrer_msg_ar": referrerMsgAr,
    "company_location": companyLocation,
    "membership_level": membershipLevel,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.phone,
    this.role,
    this.userGroupLevel,
    this.refererId,
    this.points,
    this.totalPoints,
    this.pendingPoints,
    this.levelPoints,
    this.redeemedPoints,
    this.notificationsCount,
    this.status,
    this.referCode,
    this.lastVisit,
    this.referingCount,
    this.userCode,
    this.deviceToken,
    this.gender,
    this.birthdate,
    this.email,
    this.photo,
    this.emailVerifiedAt,
    this.checkingReviewDate,
    this.facebookReviewDate,
    this.checkinReviewStatus,
    this.googleReviewStatus,
    this.facebookReviewStatus,
    this.googleStatus,
    this.googleReviewDate,
    this.facebookStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? phone;
  String? role;
  dynamic userGroupLevel;
  dynamic refererId;
  dynamic points;
  dynamic totalPoints;
  dynamic pendingPoints;
  dynamic levelPoints;
  dynamic redeemedPoints;
  dynamic notificationsCount;
  dynamic status;
  dynamic referCode;
  dynamic lastVisit;
  dynamic referingCount;
  dynamic userCode;
  String? deviceToken;
  String? gender;
  String? birthdate;
  String? email;
  String? photo;
  dynamic emailVerifiedAt;
  dynamic checkingReviewDate;
  dynamic facebookReviewDate;
  dynamic checkinReviewStatus;
  dynamic googleReviewStatus;
  dynamic facebookReviewStatus;
  dynamic googleStatus;
  dynamic googleReviewDate;
  dynamic facebookStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    role: json["role"],
    userGroupLevel: json["user_group_level"],
    refererId: json["referer_id"],
    points: json["points"],
    totalPoints: json["total_points"],
    pendingPoints: json["pending_points"],
    levelPoints: json["level_points"],
    redeemedPoints: json["redeemed_points"],
    notificationsCount: json["notifications_count"],
    status: json["status"],
    referCode: json["refer_code"],
    lastVisit: json["last_visit"],
    referingCount: json["refering_count"],
    userCode: json["user_code"],
    deviceToken: json["device_token"],
    gender: json["gender"],
    birthdate: json["birthdate"],
    email: json["email"],
    photo: json["photo"],
    emailVerifiedAt: json["email_verified_at"],
    checkingReviewDate: json["checking_review_date"],
    facebookReviewDate: json["facebook_review_date"],
    checkinReviewStatus: json["checkin_review_status"],
    googleReviewStatus: json["google_review_status"],
    facebookReviewStatus: json["facebook_review_status"],
    googleStatus: json["google_status"],
    googleReviewDate: json["google_review_date"],
    facebookStatus: json["facebook_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "role": role,
    "user_group_level": userGroupLevel,
    "referer_id": refererId,
    "points": points,
    "total_points": totalPoints,
    "pending_points": pendingPoints,
    "level_points": levelPoints,
    "redeemed_points": redeemedPoints,
    "notifications_count": notificationsCount,
    "status": status,
    "refer_code": referCode,
    "last_visit": lastVisit,
    "refering_count": referingCount,
    "user_code": userCode,
    "device_token": deviceToken,
    "gender": gender,
    "birthdate": birthdate,
    "email": email,
    "photo": photo,
    "email_verified_at": emailVerifiedAt,
    "checking_review_date": checkingReviewDate,
    "facebook_review_date": facebookReviewDate,
    "checkin_review_status": checkinReviewStatus,
    "google_review_status": googleReviewStatus,
    "facebook_review_status": facebookReviewStatus,
    "google_status": googleStatus,
    "google_review_date": googleReviewDate,
    "facebook_status": facebookStatus,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

