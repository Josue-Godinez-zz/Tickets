import 'dart:convert';
import 'dart:ffi';
import 'package:mongo_dart/mongo_dart.dart';

BookingDto mongoDBModelFromJson(String str) =>
    BookingDto.fromJson(jsonDecode(str));
String mongoDBModelToJson(BookingDto data) => jsonEncode(data.toJson);

///Class for handle the information about one BookingDto
class BookingDto {
  ObjectId? id;
  String row = '';
  String column = '';
  ObjectId? showId;

  BookingDto({
    required this.id,
    required this.row,
    required this.column,
    required this.showId,
  });

  BookingDto.empty() {
    row = '';
    column = '';
  }

  ///Convert Json object to BookingDto object
  factory BookingDto.fromJson(Map<String, dynamic> json) => BookingDto(
        id: json["_id"],
        row: json['row'],
        column: json['column'],
        showId: json["show"],
      );

  ///Convert BookingDto object to Json object
  Map<String, dynamic> toJson() =>
      {"_id": id, "row": row, 'column': column, "show": showId};

  ///Convert BookingDto object to Json object withot id object
  Map<String, dynamic> toJsonWithoutId() =>
      {"row": row, 'column': column, "show": showId};
}
