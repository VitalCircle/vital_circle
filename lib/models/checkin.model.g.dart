// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkin _$CheckinFromJson(Map<String, dynamic> json) {
  return Checkin(
    feeling: json['feeling'] as String,
    temp: (json['temp'] as num)?.toDouble(),
    subjectiveTemp: json['subjectiveTemp'] as String,
    symptoms: json['symptoms'] == null
        ? null
        : Symptoms.fromJson(json['symptoms'] as Map<String, dynamic>),
    timestamp: Checkin._datetimeFromTimestamp(json['timestamp'] as Timestamp),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$CheckinToJson(Checkin instance) => <String, dynamic>{
      'feeling': instance.feeling,
      'temp': instance.temp,
      'subjectiveTemp': instance.subjectiveTemp,
      'symptoms': instance.symptoms?.toJson(),
      'timestamp': Checkin._datetimeAsIs(instance.timestamp),
      'id': instance.id,
    };

Symptoms _$SymptomsFromJson(Map<String, dynamic> json) {
  return Symptoms(
    bodyAches: json['bodyAches'] as int ?? 0,
    cough: json['cough'] as int ?? 0,
    diarrhea: json['diarrhea'] as int ?? 0,
    febrile: json['febrile'] as int ?? 0,
    feelingIll: json['feelingIll'] as int ?? 0,
    headache: json['headache'] as int ?? 0,
    nauseaVomiting: json['nauseaVomiting'] as int ?? 0,
    oddSmell: json['oddSmell'] as int ?? 0,
    oddTaste: json['oddTaste'] as int ?? 0,
    runnyNose: json['runnyNose'] as int ?? 0,
    shortnessOfBreath: json['shortnessOfBreath'] as int ?? 0,
    sneezing: json['sneezing'] as int ?? 0,
    soreThroat: json['soreThroat'] as int ?? 0,
  );
}

Map<String, dynamic> _$SymptomsToJson(Symptoms instance) => <String, dynamic>{
      'bodyAches': instance.bodyAches,
      'cough': instance.cough,
      'diarrhea': instance.diarrhea,
      'febrile': instance.febrile,
      'feelingIll': instance.feelingIll,
      'headache': instance.headache,
      'nauseaVomiting': instance.nauseaVomiting,
      'oddSmell': instance.oddSmell,
      'oddTaste': instance.oddTaste,
      'runnyNose': instance.runnyNose,
      'shortnessOfBreath': instance.shortnessOfBreath,
      'sneezing': instance.sneezing,
      'soreThroat': instance.soreThroat,
    };
