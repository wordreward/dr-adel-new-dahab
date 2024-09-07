

import 'dart:convert';

import 'login_model.dart';

GetTransactionsModel getTransactionsModelFromJson(String str) => GetTransactionsModel.fromJson(json.decode(str));

String getTransactionsModelToJson(GetTransactionsModel data) => json.encode(data.toJson());

class GetTransactionsModel {
  GetTransactionsModel({
    this.status,
    this.transactions,
    this.user,
    this.companyWhatsapp,
    this.companyPhone,
    this.companyLocation,
    this.membershipLevel,
  });

  String? status;
  List<Transaction>? transactions;
  User? user;
  String? companyWhatsapp;
  String? companyPhone;
  String? companyLocation;
  String? membershipLevel;

  factory GetTransactionsModel.fromJson(Map<String, dynamic> json) => GetTransactionsModel(
    status: json["status"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    user: User.fromJson(json["user"]),
    companyWhatsapp: json["company_whatsapp"],
    companyPhone: json["company_phone"],
    companyLocation: json["company_location"],
    membershipLevel: json["membership_level"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "user": user!.toJson(),
    "company_whatsapp": companyWhatsapp,
    "company_phone": companyPhone,
    "company_location": companyLocation,
    "membership_level": membershipLevel,
  };
}

class Transaction {
  Transaction({
    this.name,
    this.points,
    this.date,
  });

  String? name;
  dynamic points;
  String? date;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    name: json["name"],
    points: json["points"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "points": points,
    "date": date,
  };
}
