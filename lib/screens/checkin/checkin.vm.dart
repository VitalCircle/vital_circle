import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/routes.dart';

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
    checkin.symptoms = Symptoms.empty();
    checkin.symptoms.febrile =
        _selectedSymptoms.contains(Symptom.Fever) ? 1 : 0;
    checkin.symptoms.cough = _selectedSymptoms.contains(Symptom.Cough) ? 1 : 0;
    checkin.symptoms.shortnessOfBreath =
        _selectedSymptoms.contains(Symptom.ShortOfBreath) ? 1 : 0;
    checkin.symptoms.feelingIll =
        _selectedSymptoms.contains(Symptom.FeelingIll) ? 1 : 0;
    checkin.symptoms.headache =
        _selectedSymptoms.contains(Symptom.Headache) ? 1 : 0;
    checkin.symptoms.bodyAches =
        _selectedSymptoms.contains(Symptom.BodyAches) ? 1 : 0;
    checkin.symptoms.oddTaste =
        _selectedSymptoms.contains(Symptom.OddTaste) ? 1 : 0;
    checkin.symptoms.oddSmell =
        _selectedSymptoms.contains(Symptom.OddSmell) ? 1 : 0;
    checkin.symptoms.sneezing =
        _selectedSymptoms.contains(Symptom.Sneezing) ? 1 : 0;
    checkin.symptoms.runnyNose =
        _selectedSymptoms.contains(Symptom.RunnyNose) ? 1 : 0;
    checkin.symptoms.soreThroat =
        _selectedSymptoms.contains(Symptom.SoreThroat) ? 1 : 0;
    checkin.symptoms.nauseaVomiting =
        _selectedSymptoms.contains(Symptom.NauseaVomiting) ? 1 : 0;
    checkin.symptoms.diarrhea =
        _selectedSymptoms.contains(Symptom.Diarrhea) ? 1 : 0;
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
      Navigator.pushNamedAndRemoveUntil(context, RouteName.CheckinDone,
          ModalRoute.withName(RouteName.Dashboard));
      // Navigator.of(context).pop();
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }
}
