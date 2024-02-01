import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/services/appearance_service.dart';
import 'package:shopengo/core/services/environment_service.dart';
import 'package:shopengo/core/services/router_service.dart';

void injectServices() {
  KiwiContainer().registerSingleton((container) => RouterService());
  KiwiContainer().registerSingleton((container) => EnvironmentService());
  KiwiContainer().registerSingleton((container) => AppearanceService());
}
