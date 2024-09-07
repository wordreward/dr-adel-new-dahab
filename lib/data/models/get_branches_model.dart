// To parse this JSON data, do
//
//     final getBranchesModel = getBranchesModelFromJson(jsonString);

import 'dart:convert';

GetBranchesModel getBranchesModelFromJson(String str) => GetBranchesModel.fromJson(json.decode(str));

String getBranchesModelToJson(GetBranchesModel data) => json.encode(data.toJson());

class GetBranchesModel {
    String? success;
    List<Branch>? branches;

    GetBranchesModel({
        this.success,
        this.branches,
    });

    factory GetBranchesModel.fromJson(Map<String, dynamic> json) => GetBranchesModel(
        success: json["success"],
        branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    };
}

class Branch {
    int? id;
    String? name;
    String? address;
    String? city;
    String? location;
    String? whatsAppPhone;
    String? phone;
    String? facebook;
    String? googleReview;
    String? website;
    String? instagram;
    String? status;
    

    Branch({
        this.id,
        this.name,
        this.address,
        this.city,
        this.location,
        this.whatsAppPhone,
        this.phone,
        this.facebook,
        this.googleReview,
        this.website,
        this.instagram,
        this.status,
        
    });

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        location: json["location"],
        whatsAppPhone: json["whats_app_phone"],
        phone: json["phone"],
        facebook: json["facebook"],
        googleReview: json["google_review"],
        website: json["website"],
        instagram: json["instagram"],
        status: json["status"],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "location": location,
        "whats_app_phone": whatsAppPhone,
        "phone": phone,
        "facebook": facebook,
        "google_review": googleReview,
        "website": website,
        "instagram": instagram,
        "status": status,
        
    };
}
