import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/domain/repository/theme_repository.dart';
import 'package:shopengo/core/presentation/navigation/router_configuration.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';
import 'package:shopengo/feature/shopping_list/data/datasource/shopping_list_datasource.dart';
import 'package:shopengo/feature/shopping_list/data/repository/shopping_list_repository_impl.dart';

final container = KiwiContainer();

void initDI() {
  final appDatabase = AppDatabase();

  container
    ..registerSingleton((container) => StoreDatasource(appDatabase))
    ..registerSingleton((container) => ShoppingListDatasource(appDatabase))
    ..registerSingleton((container) => ThemeRepository())
    ..registerSingleton((container) => RouterConfiguration())
    ..registerSingleton((container) => StoreRepositoryImpl(container.resolve<StoreDatasource>()))
    ..registerSingleton((container) => ShoppingListRepositoryImpl(container.resolve<ShoppingListDatasource>()));
}
