import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Company{
  late String name;
  late String catchPhrase;
  late String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

}