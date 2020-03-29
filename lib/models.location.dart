import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()

class Location {
  final String latitude;
  final String longitude;

  Location({this.latitude, this.longitude});
  
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}