import 'package:basketwise/core/domain/repository/theme_repository.dart';
import 'package:basketwise/core/presentation/navigation/router_configuration.dart';
import 'package:basketwise/core/presentation/utils/app_database.dart';
import 'package:basketwise/feature/cart/data/datasource/cart_datasource.dart';
import 'package:basketwise/feature/cart/data/mapper/cart_item_mapper.dart';
import 'package:basketwise/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:basketwise/feature/category/data/datasource/category_datasource.dart';
import 'package:basketwise/feature/category/data/mapper/category_mapper.dart';
import 'package:basketwise/feature/category/data/repository/category_repository_impl.dart';
import 'package:basketwise/feature/history/data/datasource/history_datasource.dart';
import 'package:basketwise/feature/history/data/mapper/shopping_history_mapper.dart';
import 'package:basketwise/feature/history/data/repository/history_repository_impl.dart';
import 'package:basketwise/feature/home/data/datasource/store_datasource.dart';
import 'package:basketwise/feature/home/data/mapper/store_mapper.dart';
import 'package:basketwise/feature/home/data/repository/store_repository_impl.dart';
import 'package:basketwise/feature/product/data/datasource/product_datasource.dart';
import 'package:basketwise/feature/product/data/mapper/product_mapper.dart';
import 'package:basketwise/feature/product/data/repository/product_repository_impl.dart';
import 'package:kiwi/kiwi.dart';

final container = KiwiContainer();

void initDI() {
  container
    ..registerSingleton((container) => AppDatabase())
    ..registerSingleton((container) => StoreDatasource(container.resolve<AppDatabase>()))
    ..registerSingleton((container) => ProductDatasource(container.resolve<AppDatabase>()))
    ..registerSingleton((container) => CartDatasource(container.resolve<AppDatabase>()))
    ..registerSingleton((container) => CategoryDatasource(container.resolve<AppDatabase>()))
    ..registerSingleton((container) => HistoryDatasource(container.resolve<AppDatabase>()))
    ..registerSingleton((container) => ThemeRepository())
    ..registerSingleton((container) => RouterConfiguration())
    ..registerSingleton((container) => const StoreMapper())
    ..registerSingleton(
      (container) => StoreRepositoryImpl(container.resolve<StoreDatasource>(), container.resolve<StoreMapper>()),
    )
    ..registerSingleton((container) => const ProductMapper())
    ..registerSingleton(
      (container) => ProductRepositoryImpl(container.resolve<ProductDatasource>(), container.resolve<ProductMapper>()),
    )
    ..registerSingleton((container) => const CartItemMapper())
    ..registerSingleton(
      (container) => CartRepositoryImpl(container.resolve<CartDatasource>(), container.resolve<CartItemMapper>()),
    )
    ..registerSingleton((container) => const CategoryMapper())
    ..registerSingleton(
      (container) =>
          CategoryRepositoryImpl(container.resolve<CategoryDatasource>(), container.resolve<CategoryMapper>()),
    )
    ..registerSingleton((container) => const ShoppingHistoryMapper())
    ..registerSingleton(
      (container) =>
          HistoryRepositoryImpl(container.resolve<HistoryDatasource>(), container.resolve<ShoppingHistoryMapper>()),
    );
}
