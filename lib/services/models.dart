import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ModelTest {
  @JsonKey(defaultValue: '')
  final String title;

  ModelTest({this.title});

  factory ModelTest.fromJson(Map<String, dynamic> json) =>
      _$ModelTestFromJson(json);
  Map<String, dynamic> toJson() => _$ModelTestToJson(this);
}
