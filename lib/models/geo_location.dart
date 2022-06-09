import 'package:json_annotation/json_annotation.dart';

part 'geo_location.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Geo{
  late String lat;
  late String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}