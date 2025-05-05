import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/domain/repository/theme_repository.dart';
import 'package:shopengo/core/presentation/navigation/router_configuration.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';

final container = KiwiContainer();

void initDI() {
  container
    ..registerSingleton((container) => StoreDatasource(AppDatabase()))
    ..registerSingleton((container) => ThemeRepository())
    ..registerSingleton((container) => RouterConfiguration())
    ..registerSingleton((container) => StoreRepositoryImpl(container.resolve<StoreDatasource>()));
}
