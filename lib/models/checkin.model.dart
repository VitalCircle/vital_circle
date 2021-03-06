import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/enums/subjective_temp.dart';
import 'package:vital_circle/enums/symptoms.dart';

part 'checkin.model.g.dart';

// spec: https://flutter.dev/docs/development/data-and-backend/json

// adding ID to JsonSerializable:
// https://stackoverflow.com/questions/57514264/how-to-deserialize-firestore-document-with-its-id-using-json-serializable-in-flu

//* Known Bugs/Issues
// maps work, arrays don't, since they aren't in <String, dynamic> format
// anymap: true is used as a temporary workaround for this
// https://github.com/flutter/flutter/issues/17417

// null lists often throw exceptions
// https://github.com/dart-lang/json_serializable/issues/583

// though more complex, built_value may be a more robust option for our Firestore data model
// https://medium.com/flutter/some-options-for-deserializing-json-with-flutter-7481325a4450

class CheckinProperty {
  static const FEELING = 'feeling';
  static const TEMP = 'temp';
  static const SUBJECTIVE_TEMP = 'subjectiveTemp';
  static const SYMPTOMS = 'symptoms';
  static const TIMESTAMP = 'timestamp';
}

class SymptomsProperty {
  static const BODY_ACHES = 'bodyAches';
  static const COUGH = 'cough';
  static const DIARRHEA = 'diarrhea';
  static const FEBRILE = 'febrile';
  static const FEELING_ILL = 'feelingIll';
  static const HEADACHE = 'headache';
  static const NAUSEA_VOMITING = 'nauseaVomiting';
  static const ODD_TASTE = 'oddTaste';
  static const ODD_SMELL = 'oddSmell';
  static const RUNNY_NOSE = 'runnyNose';
  static const SHORTNESS_OF_BREATH = 'shortnessOfBreath';
  static const SNEEZING = 'sneezing';
  static const SORE_THROAT = 'soreThroat';
}

class FeelingOption {
  static const BETTER = 'Better than ever!';
  static const SIMILAR = 'Pretty similar to yesterday.';
  static const WORSE = 'Worse than yesterday.';
}

class SubjectiveTempOption {
  static const HOT = 'Feeling hot';
  static const FINE = 'Feeling fine';
  static const UNSURE = 'Unsure';
}

String getSubjectiveTempTitle(SubjectiveTemp subjectiveTemp) {
  switch (subjectiveTemp) {
    case SubjectiveTemp.hot:
      return SubjectiveTempOption.HOT;
    case SubjectiveTemp.fine:
      return SubjectiveTempOption.FINE;
    case SubjectiveTemp.unsure:
      return SubjectiveTempOption.UNSURE;
  }
  return SubjectiveTempOption.UNSURE;
}

// * ----------------------------
// ?          Checkins SubCollection
// * ----------------------------

@JsonSerializable(explicitToJson: true)
class Checkin {
  Checkin({
    this.feeling,
    this.temp,
    this.subjectiveTemp,
    this.symptoms,
    this.timestamp,
  });

  factory Checkin.fromJson(String id, Map<String, dynamic> json) =>
      _$CheckinFromJson(json)..id = id; // todo: null safety check for id?

  Map<String, dynamic> toJson() => _$CheckinToJson(this);

  @JsonKey(name: CheckinProperty.FEELING)
  String feeling;
  @JsonKey(name: CheckinProperty.TEMP)
  //todo: is default value necessary?
  double temp;
  @JsonKey(name: CheckinProperty.SUBJECTIVE_TEMP)
  String subjectiveTemp;
  @JsonKey(name: CheckinProperty.SYMPTOMS)
  Symptoms symptoms;
  @JsonKey(name: CheckinProperty.TIMESTAMP, fromJson: _datetimeFromTimestamp, toJson: _datetimeAsIs)
  //todo: implement default as timestamp.now?
  DateTime timestamp;

  // https://stackoverflow.com/questions/60793441/how-do-i-resolve-type-timestamp-is-not-a-subtype-of-type-string-in-type-cast
  // todo: extract into ParseUtil
  static DateTime _datetimeFromTimestamp(Timestamp ts) => DateTime.parse(ts.toDate().toString());
  static DateTime _datetimeAsIs(DateTime dt) => dt;

  // document ID for the current checkin
  String id;
}

@JsonSerializable()
class Symptoms {
  Symptoms({
    this.cough,
    this.bodyAches,
    this.diarrhea,
    this.feelingIll,
    this.headache,
    this.nauseaVomiting,
    this.oddSmell,
    this.oddTaste,
    this.runnyNose,
    this.shortnessOfBreath,
    this.sneezing,
    this.soreThroat,
  });

  factory Symptoms.fromJson(Map<String, dynamic> json) => _$SymptomsFromJson(json);
  Map<String, dynamic> toJson() => _$SymptomsToJson(this);

  @JsonKey(name: SymptomsProperty.BODY_ACHES, defaultValue: 0)
  int bodyAches;
  @JsonKey(name: SymptomsProperty.COUGH, defaultValue: 0)
  int cough;
  @JsonKey(name: SymptomsProperty.DIARRHEA, defaultValue: 0)
  int diarrhea;
  @JsonKey(name: SymptomsProperty.FEELING_ILL, defaultValue: 0)
  int feelingIll;
  @JsonKey(name: SymptomsProperty.HEADACHE, defaultValue: 0)
  int headache;
  @JsonKey(name: SymptomsProperty.NAUSEA_VOMITING, defaultValue: 0)
  int nauseaVomiting;
  @JsonKey(name: SymptomsProperty.ODD_SMELL, defaultValue: 0)
  int oddSmell;
  @JsonKey(name: SymptomsProperty.ODD_TASTE, defaultValue: 0)
  int oddTaste;
  @JsonKey(name: SymptomsProperty.RUNNY_NOSE, defaultValue: 0)
  int runnyNose;
  @JsonKey(name: SymptomsProperty.SHORTNESS_OF_BREATH, defaultValue: 0)
  int shortnessOfBreath;
  @JsonKey(name: SymptomsProperty.SNEEZING, defaultValue: 0)
  int sneezing;
  @JsonKey(name: SymptomsProperty.SORE_THROAT, defaultValue: 0)
  int soreThroat;

  Set<Symptom> toList() {
    final symptoms = <Symptom>{};
    if (cough != null && cough > 0) {
      symptoms.add(Symptom.Cough);
    }
    if (shortnessOfBreath != null && shortnessOfBreath > 0) {
      symptoms.add(Symptom.ShortOfBreath);
    }
    if (feelingIll != null && feelingIll > 0) {
      symptoms.add(Symptom.FeelingIll);
    }
    if (headache != null && headache > 0) {
      symptoms.add(Symptom.Headache);
    }
    if (bodyAches != null && bodyAches > 0) {
      symptoms.add(Symptom.BodyAches);
    }
    if (oddTaste != null && oddTaste > 0) {
      symptoms.add(Symptom.OddTaste);
    }
    if (oddSmell != null && oddSmell > 0) {
      symptoms.add(Symptom.OddSmell);
    }
    if (sneezing != null && sneezing > 0) {
      symptoms.add(Symptom.Sneezing);
    }
    if (runnyNose != null && runnyNose > 0) {
      symptoms.add(Symptom.RunnyNose);
    }
    if (nauseaVomiting != null && nauseaVomiting > 0) {
      symptoms.add(Symptom.NauseaVomiting);
    }
    if (diarrhea != null && diarrhea > 0) {
      symptoms.add(Symptom.Diarrhea);
    }
    if (soreThroat != null && soreThroat > 0) {
      symptoms.add(Symptom.SoreThroat);
    }
    return symptoms;
  }
}
