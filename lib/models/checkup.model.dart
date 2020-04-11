import 'package:cloud_firestore/cloud_firestore.dart';

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
  static const SNEEZING_RUNNY_NOSE = 'sneezingOrRunnyNose';
  static const SORE_THROAT = 'soreThroat';
  static const OTHER = 'other';
  static const TIMESTAMP = 'timestamp';
}

class Checkup {
  Checkup(this.id, this.febrile, this.shortnessOfBreath, this.feelingIll, this.headache, this.bodyAches, this.oddTaste,
      this.oddSmell, this.sneezingOrRunnyNose, this.soreThroat, this.other, this.timestamp);

  Checkup.empty();

  Checkup.fromFirestore(this.id, Map<String, dynamic> location)
      : temp = double.tryParse(location[CheckupProperty.TEMPERATURE]),
        febrile = int.tryParse(location[CheckupProperty.FEBRILE]),
        cough = int.tryParse(location[CheckupProperty.COUGH]),
        shortnessOfBreath = int.tryParse(location[CheckupProperty.SHORTNESS_OF_BREATH]),
        feelingIll = int.tryParse(location[CheckupProperty.FEELING_ILL]),
        headache = int.tryParse(location[CheckupProperty.HEADACHE]),
        bodyAches = int.tryParse(location[CheckupProperty.BODY_ACHES]),
        oddTaste = int.tryParse(location[CheckupProperty.ODD_TASTE]),
        oddSmell = int.tryParse(location[CheckupProperty.ODD_SMELL]),
        sneezingOrRunnyNose = int.tryParse(location[CheckupProperty.SNEEZING_RUNNY_NOSE]),
        soreThroat = int.tryParse(location[CheckupProperty.SORE_THROAT]),
        other = int.tryParse(location[CheckupProperty.OTHER]),
        timestamp = _toDateTime(location[CheckupProperty.TIMESTAMP]);

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
      CheckupProperty.SNEEZING_RUNNY_NOSE: sneezingOrRunnyNose,
      CheckupProperty.SORE_THROAT: soreThroat,
      CheckupProperty.TIMESTAMP: FieldValue.serverTimestamp()
    };
  }

  static DateTime _toDateTime(Timestamp timestamp) {
    return timestamp != null ? timestamp.toDate() : null;
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
  int sneezingOrRunnyNose = 0;
  int soreThroat = 0;
  int other = 0;
  DateTime timestamp;
}
