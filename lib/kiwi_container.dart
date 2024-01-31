import 'package:kiwi/kiwi.dart';
import 'package:shopengo/services/appearance_service.dart';
import 'package:shopengo/services/environment_service.dart';
import 'package:shopengo/services/router_service.dart';

void injectServices() {
  KiwiContainer().registerSingleton((container) => RouterService());
  KiwiContainer().registerSingleton((container) => EnvironmentService());
  KiwiContainer().registerSingleton((container) => AppearanceService());
}
