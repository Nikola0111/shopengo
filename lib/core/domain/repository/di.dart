import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/domain/repository/theme_repository.dart';
import 'package:shopengo/core/presentation/navigation/router_configuration.dart';

final container = KiwiContainer();

void initDI() {
  container
    ..registerSingleton((container) => ThemeRepository())
    ..registerSingleton((container) => RouterConfiguration());
}
