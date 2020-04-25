import 'package:flutter/material.dart';
import 'package:vital_circle/constants/icons.dart';
import 'package:vital_circle/enums/subjective_temp.dart';
import 'package:vital_circle/enums/symptoms.dart';

class IconProperty {
  Image getIconFromSymptom(Symptom symptom) {
    switch (symptom) {
      case Symptom.Cough:
        return _imageByAsset(AppIcons.COUGH);
      case Symptom.Sneezing:
        return _imageByAsset(AppIcons.SNEEZING);
      case Symptom.ShortOfBreath:
        return _imageByAsset(AppIcons.SHORT_OF_BREATH);
      case Symptom.SoreThroat:
        return _imageByAsset(AppIcons.SORE_THROAT);
      case Symptom.BodyAches:
        return _imageByAsset(AppIcons.BODY_ACHES);
      case Symptom.Headache:
        return _imageByAsset(AppIcons.HEADACHE);
      case Symptom.FeelingIll:
        return _imageByAsset(AppIcons.FEELING_ILL);
      case Symptom.Diarrhea:
        return _imageByAsset(AppIcons.DIARRHEA);
      case Symptom.NauseaVomiting:
        return _imageByAsset(AppIcons.VOMITING);
      case Symptom.RunnyNose:
        return _imageByAsset(AppIcons.RUNNY_NOSE);
      case Symptom.OddTaste:
        return _imageByAsset(AppIcons.ODD_TASTE);
      case Symptom.OddSmell:
        return _imageByAsset(AppIcons.ODD_SMELL);
    }

    return _imageByAsset(AppIcons.TEMP_UNKNOWN);
  }

  Image getIconFromTemp(SubjectiveTemp subjectiveTemp) {
    switch (subjectiveTemp) {
      case SubjectiveTemp.hot:
        return _imageByAsset(AppIcons.TEMP_FEVER);
      case SubjectiveTemp.fine:
        return _imageByAsset(AppIcons.TEMP_HALF);
      case SubjectiveTemp.unsure:
        return _imageByAsset(AppIcons.TEMP_UNKNOWN);
    }
    return _imageByAsset(AppIcons.TEMP_UNKNOWN);
  }

  Image _imageByAsset(String s) => Image.asset(s, width: 24);
}
