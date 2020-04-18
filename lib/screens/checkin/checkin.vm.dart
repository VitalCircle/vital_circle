import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';

class CheckinViewModel extends ChangeNotifier {
  CheckinViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkinApi = Provider.of(context);

  final AuthService _authService;
  final CheckinApi _checkinApi;

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

  Checkin _getModel() {
    final checkin = Checkin.empty();
    checkin.temp = temperature;
    checkin.febrile = _selectedSymptoms.contains(Symptom.Fever) ? 1 : 0;
    checkin.cough = _selectedSymptoms.contains(Symptom.Cough) ? 1 : 0;
    checkin.shortnessOfBreath = _selectedSymptoms.contains(Symptom.ShortOfBreath) ? 1 : 0;
    checkin.feelingIll = _selectedSymptoms.contains(Symptom.FeelingIll) ? 1 : 0;
    checkin.headache = _selectedSymptoms.contains(Symptom.Headache) ? 1 : 0;
    checkin.bodyAches = _selectedSymptoms.contains(Symptom.BodyAches) ? 1 : 0;
    checkin.oddTaste = _selectedSymptoms.contains(Symptom.OddTaste) ? 1 : 0;
    checkin.oddSmell = _selectedSymptoms.contains(Symptom.OddSmell) ? 1 : 0;
    checkin.sneezing = _selectedSymptoms.contains(Symptom.Sneezing) ? 1 : 0;
    checkin.runnyNose = _selectedSymptoms.contains(Symptom.RunnyNose) ? 1 : 0;
    checkin.soreThroat = _selectedSymptoms.contains(Symptom.SoreThroat) ? 1 : 0;
    checkin.nauseaVomiting = _selectedSymptoms.contains(Symptom.NauseaVomiting) ? 1 : 0;
    checkin.diarrhea = _selectedSymptoms.contains(Symptom.Diarrhea) ? 1 : 0;
    return checkin;
  }

  Future submit(BuildContext context) async {
    if (_isSaving) {
      return;
    }
    _isSaving = true;
    notifyListeners();

    try {
      final user = await _authService.user;
      final checkin = _getModel();
      _checkinApi.addCheckin(user.uid, checkin);
      Navigator.of(context).pop();
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }
}
