import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/utils/parse_util.dart';

class CheckinProperty {
  static const TEMPERATURE = 'temp';
  static const FEBRILE = 'febrile';
  static const COUGH = 'cough';
  static const SHORTNESS_OF_BREATH = 'shortnessOfBreath';
  static const FEELING_ILL = 'feelingIll';
  static const HEADACHE = 'headache';
  static const BODY_ACHES = 'bodyAches';
  static const ODD_TASTE = 'oddTaste';
  static const ODD_SMELL = 'oddSmell';
  static const SNEEZING = 'sneezing';
  static const RUNNY_NOSE = 'runnyNose';
  static const SORE_THROAT = 'soreThroat';
  static const NAUSEA_VOMITING = 'nauseaVomiting';
  static const DIARRHEA = 'diarrhea';
  static const OTHER = 'other';
  static const TIMESTAMP = 'timestamp';
}

class Checkin {
  Checkin(
      this.id,
      this.febrile,
      this.shortnessOfBreath,
      this.feelingIll,
      this.headache,
      this.bodyAches,
      this.oddTaste,
      this.oddSmell,
      this.sneezing,
      this.runnyNose,
      this.soreThroat,
      this.nauseaVomiting,
      this.diarrhea,
      this.other,
      this.timestamp);

  Checkin.empty();

  Checkin.fromFirestore(this.id, Map<String, dynamic> location)
      : temp = ParseUtil.tryParseDouble(location[CheckinProperty.TEMPERATURE]),
        febrile = ParseUtil.tryParseInt(location[CheckinProperty.FEBRILE]),
        cough = ParseUtil.tryParseInt(location[CheckinProperty.COUGH]),
        shortnessOfBreath = ParseUtil.tryParseInt(location[CheckinProperty.SHORTNESS_OF_BREATH]),
        feelingIll = ParseUtil.tryParseInt(location[CheckinProperty.FEELING_ILL]),
        headache = ParseUtil.tryParseInt(location[CheckinProperty.HEADACHE]),
        bodyAches = ParseUtil.tryParseInt(location[CheckinProperty.BODY_ACHES]),
        oddTaste = ParseUtil.tryParseInt(location[CheckinProperty.ODD_TASTE]),
        oddSmell = ParseUtil.tryParseInt(location[CheckinProperty.ODD_SMELL]),
        sneezing = ParseUtil.tryParseInt(location[CheckinProperty.SNEEZING]),
        runnyNose = ParseUtil.tryParseInt(location[CheckinProperty.RUNNY_NOSE]),
        soreThroat = ParseUtil.tryParseInt(location[CheckinProperty.SORE_THROAT]),
        nauseaVomiting = ParseUtil.tryParseInt(location[CheckinProperty.NAUSEA_VOMITING]),
        diarrhea = ParseUtil.tryParseInt(location[CheckinProperty.DIARRHEA]),
        other = ParseUtil.tryParseInt(location[CheckinProperty.OTHER]),
        timestamp = ParseUtil.tryParseDateTime(location[CheckinProperty.TIMESTAMP]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      CheckinProperty.TEMPERATURE: temp,
      CheckinProperty.FEBRILE: febrile,
      CheckinProperty.COUGH: cough,
      CheckinProperty.SHORTNESS_OF_BREATH: shortnessOfBreath,
      CheckinProperty.FEELING_ILL: feelingIll,
      CheckinProperty.HEADACHE: headache,
      CheckinProperty.BODY_ACHES: bodyAches,
      CheckinProperty.ODD_TASTE: oddTaste,
      CheckinProperty.ODD_SMELL: oddSmell,
      CheckinProperty.SNEEZING: sneezing,
      CheckinProperty.RUNNY_NOSE: runnyNose,
      CheckinProperty.SORE_THROAT: soreThroat,
      CheckinProperty.NAUSEA_VOMITING: nauseaVomiting,
      CheckinProperty.DIARRHEA: diarrhea,
      CheckinProperty.TIMESTAMP: Timestamp.now()
    };
  }

  String id;
  double temp = 0;
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
  int other = 0;
  DateTime timestamp;

  Set<Symptom> get symptoms {
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
