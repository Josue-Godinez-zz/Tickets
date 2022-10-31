import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

CinemaDto mongoDBModelFromJson(String str) =>
    CinemaDto.fromJson(jsonDecode(str));
String mongoDBModelToJson(CinemaDto data) => jsonEncode(data.toJson);

///Class for handle the information about one CinemaDto
class CinemaDto {
  ObjectId? id;
  String name = '';
  String description = '';
  String location = '';
  double numberOfWeekSales = 0;
  String status = '';

  CinemaDto(
      {required this.id,
      required this.name,
      required this.description,
      required this.location,
      required this.numberOfWeekSales,
      required this.status});

  CinemaDto.empty() {
    numberOfWeekSales = 0;
    name = '';
    description = '';
    location = '';
    status = '';
  }

  ///Convert Json object to CinemaDto object
  factory CinemaDto.fromJson(Map<String, dynamic> json) => CinemaDto(
        id: json["_id"],
        name: json['name'],
        description: (json['description'] != null) ? json['description'] : '',
        location: json['location'],
        numberOfWeekSales: json['numberOfWeekSales'],
        status: json['Status'],
      );

  ///Convert CinemaDto object to Json object
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        'description': description,
        "location": location,
        "numberOfWeekSales": numberOfWeekSales,
        "status": status,
      };

  ///Convert CinemaDto object to Json object withot id object
  Map<String, dynamic> toJsonWithoutId() => {
        "name": name,
        'description': description,
        "location": location,
        "numberOfWeekSales": numberOfWeekSales,
        "status": status,
      };

  @override
  String toString() {
    return name;
  }
}
