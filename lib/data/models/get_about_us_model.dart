// To parse this JSON data, do
//
//     final getAboutModel = getAboutModelFromJson(jsonString);

import 'dart:convert';

List<GetAboutModel> getAboutModelFromJson(String str) => List<GetAboutModel>.from(json.decode(str).map((x) => GetAboutModel.fromJson(x)));

String getAboutModelToJson(List<GetAboutModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAboutModel {
    int? id;
    String? descriptionAr;
    String? descriptionEng;

    GetAboutModel({
        this.id,
        this.descriptionAr,
        this.descriptionEng,
    });

    factory GetAboutModel.fromJson(Map<String, dynamic> json) => GetAboutModel(
        id: json["id"],
        descriptionAr: json["description_ar"],
        descriptionEng: json["description_eng"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description_ar": descriptionAr,
        "description_eng": descriptionEng,
    };
}
