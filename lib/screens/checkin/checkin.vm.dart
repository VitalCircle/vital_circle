import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vital_circle/constants/log_zone.dart';
import 'package:vital_circle/enums/symptoms.dart';
import 'package:vital_circle/models/index.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/screens/checkin/checkin_feeling.dart';
import 'package:vital_circle/services/services.dart';
import 'package:vital_circle/routes.dart';

enum CheckinSteps { CheckinFeeling, CheckinTemperature, CheckinSymptoms }

class CheckinScreenRouteData {
  CheckinScreenRouteData(this.date, this.checkin);

  final DateTime date;
  final Checkin checkin;
}

class CheckinViewModel extends ChangeNotifier {
  CheckinViewModel.of(BuildContext context)
      : _authService = Provider.of(context),
        _checkinApi = Provider.of(context),
        _routeData = ModalRoute.of(context).settings.arguments;

  final AuthService _authService;
  final CheckinApi _checkinApi;
  final CheckinScreenRouteData _routeData;

  final _log = LogService.zone(LogZone.CHECKUP);
  final formKey = GlobalKey<FormState>();

  double temperature;
  String feeling;
  String subjectiveTemp;

  var _selectedSymptoms = <Symptom>{};
  Set<Symptom> get selectedSymptoms => _selectedSymptoms;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  void init(BuildContext context) {
    if (_routeData != null && _routeData.checkin != null) {
      feeling = _routeData.checkin.feeling;
      temperature = _routeData.checkin.temp;
      subjectiveTemp = _routeData.checkin.subjectiveTemp;
      _selectedSymptoms = _routeData.checkin.symptoms.toList();
    }
    if (_steps.isEmpty) {
      initSteps(context);
    }
  }

  void toggleSelected(Symptom symptom) {
    if (_selectedSymptoms.contains(symptom)) {
      _selectedSymptoms.remove(symptom);
    } else {
      _selectedSymptoms.add(symptom);
    }
    notifyListeners();
  }

  Checkin get getModel => _getModel();

  Checkin _getModel() {
    final checkin = Checkin();
    checkin.feeling = feeling;
    checkin.temp = temperature;
    checkin.subjectiveTemp = subjectiveTemp;
    checkin.symptoms = Symptoms();
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

    if (_routeData != null) {
      if (_routeData.checkin != null) {
        checkin.id = _routeData.checkin.id;
        checkin.timestamp = _routeData.checkin.timestamp;
      } else if (_routeData.date != null) {
        checkin.timestamp = _routeData.date;
      }
    }

    return checkin;
  }

  Future submit(BuildContext context) async {
    if (_isSaving) {
      return;
    }
    formKey.currentState.save();
    _isSaving = true;
    notifyListeners();

    try {
      final user = await _authService.user;
      final checkin = _getModel();
      if (checkin.id != null) {
        _checkinApi.updateCheckin(user.uid, checkin);
      } else {
        _checkinApi.addCheckin(user.uid, checkin);
      }
      // Navigator.of(context).pop();
      // onDone(context);
      Navigator.pushNamedAndRemoveUntil(context, RouteName.CheckinSubmitted,
          ModalRoute.withName(RouteName.Dashboard));
    } catch (_) {
      _isSaving = false;
      notifyListeners();
      rethrow;
    }
  }

  // Checkin Steps
  Set<CheckinSteps> _steps = <CheckinSteps>{};
  Set<CheckinSteps> get steps => _steps;

  Future<void> initSteps(BuildContext context) async {
    _steps = _getSteps();
  }

  Set<CheckinSteps> _getSteps() {
    final steps = <CheckinSteps>{};
    steps.add(CheckinSteps.CheckinFeeling);
    steps.add(CheckinSteps.CheckinTemperature);
    steps.add(CheckinSteps.CheckinSymptoms);
    return steps;
  }

  Future<void> onDone(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, RouteName.CheckinSubmitted);
  }
}
