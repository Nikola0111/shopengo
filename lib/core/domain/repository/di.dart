import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/domain/repository/theme_repository.dart';
import 'package:shopengo/core/presentation/navigation/router_configuration.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/cart/data/datasource/cart_datasource.dart';
import 'package:shopengo/feature/cart/data/mapper/cart_item_mapper.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:shopengo/feature/category/data/datasource/category_datasource.dart';
import 'package:shopengo/feature/category/data/mapper/category_mapper.dart';
import 'package:shopengo/feature/category/data/repository/category_repository_impl.dart';
import 'package:shopengo/feature/history/data/datasource/history_datasource.dart';
import 'package:shopengo/feature/history/data/mapper/past_shopping_mapper.dart';
import 'package:shopengo/feature/history/data/repository/history_repository_impl.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/mapper/store_mapper.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';
import 'package:shopengo/feature/product/data/datasource/product_datasource.dart';
import 'package:shopengo/feature/product/data/mapper/product_mapper.dart';
import 'package:shopengo/feature/product/data/repository/product_repository_impl.dart';

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
    ..registerSingleton((container) => const PastShoppingMapper())
    ..registerSingleton(
      (container) =>
          HistoryRepositoryImpl(container.resolve<HistoryDatasource>(), container.resolve<PastShoppingMapper>()),
    );
}
