import 'package:json_annotation/json_annotation.dart';
import 'package:technical_assessment/models/address.dart';
import 'package:technical_assessment/models/company.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class User{
  late int id;
  late String name;
  late String username;
  late String email;
  late Address address;
  late String phone;
  late String website;
  late Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}