import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

ScheduleDto mongoDBModelFromJson(String str) =>
    ScheduleDto.fromJson(jsonDecode(str));
String mongoDBModelToJson(ScheduleDto data) => jsonEncode(data.toJson);

///Class for handle the information about one ScheduleDto
class ScheduleDto {
  ObjectId? id;
  String day = '';
  String hour = '';
  ObjectId? filmId;
  String? room = '';
  List<dynamic> chairs = [];

  ScheduleDto(
      {required this.id,
      required this.day,
      required this.hour,
      required this.filmId,
      required this.room,
      required this.chairs});

  ScheduleDto.empty() {
    day = '';
    hour = '';
    room = '';
    chairs = [];
  }

  ///Convert Json object to scheduleDto object
  factory ScheduleDto.fromJson(Map<String, dynamic> json) => ScheduleDto(
        id: json["_id"],
        day: json['day'],
        hour: json['hour'],
        room: json['room'],
        filmId: json["film"],
        chairs: json["chairs"],
      );

  ///Convert scheduleDto object to Json object
  Map<String, dynamic> toJson() => {
        "_id": id,
        "day": day,
        'hour': hour,
        "room": room,
        "film": filmId,
        "chairs": chairs
      };

  ///Convert scheduleDto object to Json object withot id object
  Map<String, dynamic> toJsonWithoutId() => {
        "day": day,
        'hour': hour,
        "room": room,
        "film": filmId,
        "chairs": chairs
      };
}
