import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopengo/feature/home/data/repository/store_repository.dart';
import 'package:shopengo/feature/home/domain/cubit/home_bloc.dart';
import 'package:shopengo/feature/home/domain/cubit/home_event.dart';
import 'package:shopengo/feature/home/domain/cubit/home_state.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([StoreRepository])
void main() {
  late MockStoreRepository storeRepository;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    storeRepository = MockStoreRepository();
  });

  blocTest<HomeBloc, HomeState>(
    'should start with loading state',
    build: () => HomeBloc(storeRepository),
    verify: (bloc) => expect(bloc.state, const HomeState.loading(stores: [])),
  );

  blocTest<HomeBloc, HomeState>(
    'should fetch an empty list of stores',
    setUp: () => when(storeRepository.getAllStores()).thenAnswer((_) async => <StoreModel>[]),
    build: () => HomeBloc(storeRepository),
    act: (bloc) => bloc.add(LoadStoresEvent()),
    verify: (bloc) => expect(bloc.state, const HomeState.storesReady(stores: [])),
  );

  blocTest<HomeBloc, HomeState>(
    'should fetch one store',
    setUp: () => when(storeRepository.getAllStores()).thenAnswer(
      (_) async => [StoreModel(storeName: 'merkator', id: 1)],
    ),
    build: () => HomeBloc(storeRepository),
    act: (bloc) => bloc.add(LoadStoresEvent()),
    verify: (bloc) => expect(
      bloc.state,
      HomeState.storesReady(stores: [StoreModel(storeName: 'merkator', id: 1)]),
    ),
  );

  blocTest<HomeBloc, HomeState>(
    'should create a store',
    setUp: () {
      when(storeRepository.createStore('merkator')).thenAnswer((_) async => 1);
      when(storeRepository.getAllStores()).thenAnswer((_) async => [StoreModel(id: 1, storeName: 'merkator')]);
    },
    build: () => HomeBloc(storeRepository),
    act: (bloc) => bloc.add(HomeSubmitNewStoreEvent(storeName: 'merkator')),
    verify: (bloc) => expect(bloc.state, HomeState.storesReady(stores: [StoreModel(id: 1, storeName: 'merkator')])),
  );
}
