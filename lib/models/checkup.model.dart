import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/utils/parse_util.dart';

class CheckupProperty {
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

class Checkup {
  Checkup(
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

  Checkup.empty();

  Checkup.fromFirestore(this.id, Map<String, dynamic> location)
      : temp = ParseUtil.tryParseDouble(location[CheckupProperty.TEMPERATURE]),
        febrile = ParseUtil.tryParseInt(location[CheckupProperty.FEBRILE]),
        cough = ParseUtil.tryParseInt(location[CheckupProperty.COUGH]),
        shortnessOfBreath = ParseUtil.tryParseInt(location[CheckupProperty.SHORTNESS_OF_BREATH]),
        feelingIll = ParseUtil.tryParseInt(location[CheckupProperty.FEELING_ILL]),
        headache = ParseUtil.tryParseInt(location[CheckupProperty.HEADACHE]),
        bodyAches = ParseUtil.tryParseInt(location[CheckupProperty.BODY_ACHES]),
        oddTaste = ParseUtil.tryParseInt(location[CheckupProperty.ODD_TASTE]),
        oddSmell = ParseUtil.tryParseInt(location[CheckupProperty.ODD_SMELL]),
        sneezing = ParseUtil.tryParseInt(location[CheckupProperty.SNEEZING]),
        runnyNose = ParseUtil.tryParseInt(location[CheckupProperty.RUNNY_NOSE]),
        soreThroat = ParseUtil.tryParseInt(location[CheckupProperty.SORE_THROAT]),
        nauseaVomiting = ParseUtil.tryParseInt(location[CheckupProperty.NAUSEA_VOMITING]),
        diarrhea = ParseUtil.tryParseInt(location[CheckupProperty.DIARRHEA]),
        other = ParseUtil.tryParseInt(location[CheckupProperty.OTHER]),
        timestamp = ParseUtil.tryParseDateTime(location[CheckupProperty.TIMESTAMP]);

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      CheckupProperty.TEMPERATURE: temp,
      CheckupProperty.FEBRILE: febrile,
      CheckupProperty.COUGH: cough,
      CheckupProperty.SHORTNESS_OF_BREATH: shortnessOfBreath,
      CheckupProperty.FEELING_ILL: feelingIll,
      CheckupProperty.HEADACHE: headache,
      CheckupProperty.BODY_ACHES: bodyAches,
      CheckupProperty.ODD_TASTE: oddTaste,
      CheckupProperty.ODD_SMELL: oddSmell,
      CheckupProperty.SNEEZING: sneezing,
      CheckupProperty.RUNNY_NOSE: runnyNose,
      CheckupProperty.SORE_THROAT: soreThroat,
      CheckupProperty.NAUSEA_VOMITING: nauseaVomiting,
      CheckupProperty.DIARRHEA: diarrhea,
      CheckupProperty.TIMESTAMP: FieldValue.serverTimestamp()
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
