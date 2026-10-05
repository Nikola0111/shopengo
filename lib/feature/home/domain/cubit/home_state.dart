import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

part '../../../../generated/feature/home/domain/cubit/home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const new _();
  const factory loading({required List<StoreModel> stores}) = HomeStateLoading;
  const factory storesReady({required List<StoreModel> stores}) = HomeStoresReadyState;
  const factory creatingStore({required List<StoreModel> stores}) = HomeCreatingStoreState;
  const factory searchingStores({required List<StoreModel> stores}) = HomeSearchingStoresState;
}
