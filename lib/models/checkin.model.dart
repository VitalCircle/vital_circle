import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/utils/parse_util.dart';

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

class Checkin {
  Checkin.empty();

  Checkin.fromFirestore(this.id, Map<String, dynamic> data)
      : feeling = data[CheckinProperty.FEELING],
        temp = ParseUtil.tryParseDouble(data[CheckinProperty.TEMP]),
        subjectiveTemp = data[CheckinProperty.SUBJECTIVE_TEMP],
        symptoms = Symptoms.fromFirestore(data[CheckinProperty.SYMPTOMS]),
        timestamp = ParseUtil.tryParseDateTime(data[CheckinProperty.TIMESTAMP]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      CheckinProperty.FEELING: feeling,
      CheckinProperty.TEMP: temp,
      CheckinProperty.SUBJECTIVE_TEMP: subjectiveTemp,
      CheckinProperty.SYMPTOMS: symptoms.toFirestore(),
      CheckinProperty.TIMESTAMP: timestamp ?? Timestamp.now()
    };
  }

  String id;
  // TODO: make enum
  String feeling;
  double temp = 0;
  // TODO: make enum
  String subjectiveTemp;
  Symptoms symptoms;
  DateTime timestamp;
}

class Symptoms {
  Symptoms.empty();

  Symptoms.fromFirestore(Map<String, dynamic> data)
      : febrile = ParseUtil.tryParseInt(data[SymptomsProperty.FEBRILE]),
        cough = ParseUtil.tryParseInt(data[SymptomsProperty.COUGH]),
        shortnessOfBreath = ParseUtil.tryParseInt(data[SymptomsProperty.SHORTNESS_OF_BREATH]),
        feelingIll = ParseUtil.tryParseInt(data[SymptomsProperty.FEELING_ILL]),
        headache = ParseUtil.tryParseInt(data[SymptomsProperty.HEADACHE]),
        bodyAches = ParseUtil.tryParseInt(data[SymptomsProperty.BODY_ACHES]),
        oddTaste = ParseUtil.tryParseInt(data[SymptomsProperty.ODD_TASTE]),
        oddSmell = ParseUtil.tryParseInt(data[SymptomsProperty.ODD_SMELL]),
        sneezing = ParseUtil.tryParseInt(data[SymptomsProperty.SNEEZING]),
        runnyNose = ParseUtil.tryParseInt(data[SymptomsProperty.RUNNY_NOSE]),
        soreThroat = ParseUtil.tryParseInt(data[SymptomsProperty.SORE_THROAT]),
        nauseaVomiting = ParseUtil.tryParseInt(data[SymptomsProperty.NAUSEA_VOMITING]),
        diarrhea = ParseUtil.tryParseInt(data[SymptomsProperty.DIARRHEA]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      SymptomsProperty.FEBRILE: febrile,
      SymptomsProperty.COUGH: cough,
      SymptomsProperty.SHORTNESS_OF_BREATH: shortnessOfBreath,
      SymptomsProperty.FEELING_ILL: feelingIll,
      SymptomsProperty.HEADACHE: headache,
      SymptomsProperty.BODY_ACHES: bodyAches,
      SymptomsProperty.ODD_TASTE: oddTaste,
      SymptomsProperty.ODD_SMELL: oddSmell,
      SymptomsProperty.SNEEZING: sneezing,
      SymptomsProperty.RUNNY_NOSE: runnyNose,
      SymptomsProperty.SORE_THROAT: soreThroat,
      SymptomsProperty.NAUSEA_VOMITING: nauseaVomiting,
      SymptomsProperty.DIARRHEA: diarrhea
    };
  }

  // TODO: make enum
  int febrile = 0;
  int cough = 0;
  int shortnessOfBreath = 0;
  int feelingIll = 0;
  int headache = 0;
  int bodyAches = 0;
  int oddTaste = 0;
  int oddSmell = 0;
  int sneezing = 0;
  int runnyNose = 0;
  int soreThroat = 0;
  int nauseaVomiting = 0;
  int diarrhea = 0;

  Set<Symptom> toList() {
    final symptoms = <Symptom>{};
    if (febrile != null && febrile > 0) {
      symptoms.add(Symptom.Fever);
    }
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
