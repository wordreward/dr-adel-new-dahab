// To parse this JSON data, do
//
//     final getAvailableDatesModel = getAvailableDatesModelFromJson(jsonString);

import 'dart:convert';

List<GetAvailableDatesModel> getAvailableDatesModelFromJson(String str) => List<GetAvailableDatesModel>.from(json.decode(str).map((x) => GetAvailableDatesModel.fromJson(x)));

String getAvailableDatesModelToJson(List<GetAvailableDatesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAvailableDatesModel {
    int? id;
    String? date;
    String? time;
    int? available;
   

    GetAvailableDatesModel({
        this.id,
        this.date,
        this.time,
        this.available,
       
    });

    factory GetAvailableDatesModel.fromJson(Map<String, dynamic> json) => GetAvailableDatesModel(
        id: json["id"],
        date: json["date"] ,
        time: json["time"],
        available: json["available"],
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time": time,
        "available": available,
        
    };
}
