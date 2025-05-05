import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

part '../../../../generated/feature/home/domain/cubit/home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.loading({required List<StoreModel> stores}) = HomeStateLoading;
  const factory HomeState.storesReady({required List<StoreModel> stores}) = HomeStoresReadyState;
  const factory HomeState.creatingStore({required List<StoreModel> stores}) = HomeCreatingStoreState;
  const factory HomeState.searchingStores({required List<StoreModel> stores}) = HomeSearchingStoresState;
}
