import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';

class CheckupViewModel extends ChangeNotifier {
  CheckupViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkupApi = Provider.of(context);

  final AuthService _authService;
  final CheckupApi _checkupApi;

  final _log = LogService.zone(LogZone.CHECKUP);

  double temperature;

  final _selectedSymptoms = <Symptom>{};
  Set<Symptom> get selectedSymptoms => _selectedSymptoms;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  void toggleSelected(Symptom symptom) {
    if (_selectedSymptoms.contains(symptom)) {
      _selectedSymptoms.remove(symptom);
    } else {
      _selectedSymptoms.add(symptom);
    }
    notifyListeners();
  }

  Checkup _getModel() {
    final checkup = Checkup.empty();
    checkup.temp = temperature;
    checkup.febrile = _selectedSymptoms.contains(Symptom.Fever) ? 1 : 0;
    checkup.cough = _selectedSymptoms.contains(Symptom.Cough) ? 1 : 0;
    checkup.shortnessOfBreath = _selectedSymptoms.contains(Symptom.ShortOfBreath) ? 1 : 0;
    checkup.feelingIll = _selectedSymptoms.contains(Symptom.FeelingIll) ? 1 : 0;
    checkup.headache = _selectedSymptoms.contains(Symptom.Headache) ? 1 : 0;
    checkup.bodyAches = _selectedSymptoms.contains(Symptom.BodyAches) ? 1 : 0;
    checkup.oddTaste = _selectedSymptoms.contains(Symptom.OddTaste) ? 1 : 0;
    checkup.oddSmell = _selectedSymptoms.contains(Symptom.OddSmell) ? 1 : 0;
    checkup.sneezing = _selectedSymptoms.contains(Symptom.Sneezing) ? 1 : 0;
    checkup.runnyNose = _selectedSymptoms.contains(Symptom.RunnyNose) ? 1 : 0;
    checkup.soreThroat = _selectedSymptoms.contains(Symptom.SoreThroat) ? 1 : 0;
    checkup.nauseaVomiting = _selectedSymptoms.contains(Symptom.NauseaVomiting) ? 1 : 0;
    checkup.diarrhea = _selectedSymptoms.contains(Symptom.Diarrhea) ? 1 : 0;
    return checkup;
  }

  void submit(BuildContext context) {
    if (_isSaving) {
      return;
    }
    _isSaving = true;
    notifyListeners();

    try {
      final user = _authService.user;
      final checkup = _getModel();
      _checkupApi.addCheckup(user.uid, checkup);
      Navigator.of(context).pop();
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }
}
