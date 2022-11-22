import 'dart:convert';
import 'dart:ffi';
import 'package:mongo_dart/mongo_dart.dart';

FilmDto mongoDBModelFromJson(String str) => FilmDto.fromJson(jsonDecode(str));
String mongoDBModelToJson(FilmDto data) => jsonEncode(data.toJson);

///Class for handle the information about one FilmDto
class FilmDto {
  ObjectId? id;
  String name = '';
  String description = '';
  int duration = 0;
  ObjectId? cinemaId;
  String? urlImage = '';
  String price = '';

  FilmDto(
      {required this.id,
      required this.name,
      required this.description,
      required this.duration,
      required this.cinemaId,
      required this.urlImage,
      required this.price});

  FilmDto.empty() {
    name = '';
    description = '';
    duration = 0;
    urlImage = '';
    price = '';
  }

  ///Convert Json object to FilmDto object
  factory FilmDto.fromJson(Map<String, dynamic> json) => FilmDto(
      id: json["_id"],
      name: json['name'],
      description: (json['description'] != null) ? json['description'] : '',
      duration: json['duration'],
      urlImage: (json['image'] != null) ? json['image'] : '',
      cinemaId: json["cinema"],
      price: json['priceByTicket']);

  ///Convert FilmDto object to Json object
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        'description': description,
        "duration": duration,
        "image": urlImage,
        "cinema": cinemaId,
        "priceByTicket": price
      };

  ///Convert FilmDto object to Json object withot id object
  Map<String, dynamic> toJsonWithoutId() => {
        "name": name,
        'description': description,
        "duration": duration,
        "image": urlImage,
        "cinema": cinemaId,
        "priceByTicket": price
      };

  @override
  String toString() {
    return name;
  }
}
