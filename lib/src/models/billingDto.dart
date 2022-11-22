import 'dart:convert';
import 'dart:ffi';
import 'package:mongo_dart/mongo_dart.dart';

BillingDto mongoDBModelFromJson(String str) =>
    BillingDto.fromJson(jsonDecode(str));
String mongoDBModelToJson(BillingDto data) => jsonEncode(data.toJson);

///Class for handle the information about one BillingDto
class BillingDto {
  ObjectId? id;
  ObjectId? userId;
  ObjectId? scheduleId;
  ObjectId? filmId;
  List<dynamic> chairs = [];

  BillingDto({
    required this.id,
    required this.filmId,
    required this.scheduleId,
    required this.userId,
    required this.chairs,
  });

  BillingDto.empty() {
    chairs = [];
  }

  ///Convert Json object to BillingDto object
  factory BillingDto.fromJson(Map<String, dynamic> json) => BillingDto(
      id: json["_id"],
      filmId: json['film'],
      userId: json['user'],
      scheduleId: json['schedule'],
      chairs: json["chairs"]);

  ///Convert BillingDto object to Json object
  Map<String, dynamic> toJson() => {
        "_id": id,
        "film": filmId,
        'user': userId,
        "schedule": scheduleId,
        "chairs": chairs,
      };

  ///Convert BillingDto object to Json object withot id object
  Map<String, dynamic> toJsonWithoutId() => {
        "film": filmId,
        'user': userId,
        "schedule": scheduleId,
        "chairs": chairs,
      };
}
