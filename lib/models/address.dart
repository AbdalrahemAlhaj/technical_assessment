import 'package:json_annotation/json_annotation.dart';

import 'geo_location.dart';

part 'address.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Address{
  late String street;
  late String suite;
  late String city;
  late String zipcode;
  late Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);


}