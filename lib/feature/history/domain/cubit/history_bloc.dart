import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/history/data/repository/history_repository.dart';
import 'package:shopengo/feature/history/domain/cubit/history_event.dart';
import 'package:shopengo/feature/history/domain/cubit/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  new(this._historyRepository, {required this.storeId}) : super(const HistoryState()) {
    _setupEventListeners();
  }

  final HistoryRepository _historyRepository;
  final int storeId;

  void _setupEventListeners() {
    on<HistoryLoadEvent>((event, emit) async {
      final shoppingHistory = await _historyRepository.getShoppingHistory(storeId);
      emit(state.copyWith(shoppingHistory: shoppingHistory, isLoading: false));
    });
  }
}
