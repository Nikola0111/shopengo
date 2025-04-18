import 'package:equatable/equatable.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStoresReadyState extends HomeState {
  HomeStoresReadyState({required this.stores});
  final List<StoreModel> stores;

  @override
  List<Object?> get props => [stores];
}
