import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'services/services.dart';

class ProviderModule {
  static final List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._uiConsumableProviders,
  ];

  static final List<SingleChildWidget> _independentServices = <SingleChildWidget>[];

  static final List<SingleChildWidget> _dependentServices = <SingleChildWidget>[
    Provider.value(value: GoogleAuthService()),
  ];

  static final List<SingleChildWidget> _uiConsumableProviders = <SingleChildWidget>[];
}
