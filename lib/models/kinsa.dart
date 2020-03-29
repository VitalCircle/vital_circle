import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Kinsa{
  
  final double anomalyDiff;
  final double atypicalIli;
  final double cumAnomalyFevers;
  final String date;
  final double forecastExpected;
  final double forecastLower;
  final double forecastUpper;
  final double observedIli;
  final double pctChange;
  final String regionId;
  final String regionName;
  final String state;

  Kinsa({
    this.anomalyDiff,
    this.atypicalIli,
    this.cumAnomalyFevers,
    this.date,
    this.forecastExpected,
    this.forecastLower
    this.forecastUpper
    this.observedIli
    this.pctChange,
    this.pctChange,
    this.regionId,
    this.regionName,
    this.state
    });

  factory Kinsa.fromJson(Map<String, dynamic> json) => _$KinsaFromJson(json);
  Map<String, dynamic> toJson() => _$KinsaToJson(this);
}