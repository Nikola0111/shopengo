import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopengo/feature/history/data/repository/history_repository.dart';
import 'package:shopengo/feature/history/domain/cubit/history_bloc.dart';
import 'package:shopengo/feature/history/domain/cubit/history_event.dart';
import 'package:shopengo/feature/history/domain/cubit/history_state.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_item_model.dart';
import 'package:shopengo/feature/history/domain/model/past_shopping_model.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';

import 'history_bloc_test.mocks.dart';

@GenerateMocks([HistoryRepository])
void main() {
  late MockHistoryRepository historyRepository;

  const storeId = 7;
  final latest = PastShoppingModel(
    id: 2,
    date: DateTime(2026, 9, 28),
    amountSpent: 3000,
    items: [PastShoppingItemModel(productName: 'Mleko', amountType: AmountType.liter, quantity: 2)],
  );
  final earlier = PastShoppingModel(id: 1, date: DateTime(2026, 9, 14), amountSpent: 2450.5);

  setUp(() {
    historyRepository = MockHistoryRepository();
  });

  blocTest<HistoryBloc, HistoryState>(
    "should load the store's past shoppings",
    setUp: () => when(historyRepository.getPastShoppings(storeId)).thenAnswer((_) async => [latest, earlier]),
    build: () => HistoryBloc(historyRepository, storeId: storeId),
    act: (bloc) => bloc.add(HistoryLoadEvent()),
    expect: () => [
      HistoryState(pastShoppings: [latest, earlier], isLoading: false),
    ],
  );

  test('should sum the amounts spent, skipping unknown ones', () {
    final state = HistoryState(
      pastShoppings: [latest, earlier, PastShoppingModel(id: 3, date: DateTime(2026, 9))],
      isLoading: false,
    );

    expect(state.totalSpent, 5450.5);
  });

  test('should spend nothing without shoppings', () {
    expect(const HistoryState().totalSpent, 0);
  });
}
