import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'services/services.dart';

class ProviderModule {
  static final List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._uiConsumableProviders,
  ];

  static final List<SingleChildWidget> _independentServices = <SingleChildWidget>[
    Provider.value(value: AnonymousAuthService()),
    Provider.value(value: CheckinApi()),
    Provider.value(value: GoogleAuthService()),
    Provider.value(value: LocalStorage()),
    Provider.value(value: UserApi()),
  ];

  static final List<SingleChildWidget> _dependentServices = <SingleChildWidget>[
    ProxyProvider3<LocalStorage, GoogleAuthService, AnonymousAuthService, AuthService>(
        update: (context, localStorage, googleAuthService, anonymousAuthService, _) =>
            AuthService(localStorage, googleAuthService, anonymousAuthService)),
    ProxyProvider<AuthService, GeoService>(update: (context, authService, _) => GeoService(authService)),
    ProxyProvider2<AuthService, UserApi, StartUpService>(
        update: (context, authService, userApi, _) => StartUpService(authService, userApi)),
  ];

  static final List<SingleChildWidget> _uiConsumableProviders = <SingleChildWidget>[];
}
