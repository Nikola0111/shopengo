import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shopengo/core/presentation/utils/app_database.dart';
import 'package:shopengo/feature/home/data/datasource/store_datasource.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';

@GenerateMocks([AppDatabase, StoreRepository])
void main() {
  late StoreDatasource datasource;
  late AppDatabase database;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    database = AppDatabase.forTesting(NativeDatabase.memory());
    datasource = StoreDatasource(database);
  });

  group('basic crud operations', () {
    test('return list should be empty', () async {
      final stores = await datasource.getAllStores();
      expect(stores, isEmpty);
    });

    test('creating a store', () async {
      const mercatorStoreName = 'Mercator';

      await datasource.createStore(mercatorStoreName);
      final stores = await datasource.getAllStores();

      expect(stores.length, 1);
    });
  });

  group('searching stores', () {
    test('searching a store should return 0 stores', () async {
      final stores = await datasource.searchByQuery('mer');
      expect(stores.length, 1);
    });

    test('searching a store should return 1 store', () async {
      const mercatorStoreName = 'Mercator';

      await datasource.createStore(mercatorStoreName);
      final stores = await datasource.searchByQuery('mer');

      expect(stores.length, 2);
    });
  });
}
