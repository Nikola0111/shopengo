import 'package:equatable/equatable.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class HomeState extends Equatable {
  const HomeState({required this.stores});

  final List<StoreModel> stores;

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(stores: <StoreModel>[]);

  @override
  List<Object?> get props => [];
}

class HomeStoresReadyState extends HomeState {
  const HomeStoresReadyState({required super.stores});

  @override
  List<Object?> get props => [stores];
}

class HomeCreatingStoreState extends HomeState {
  const HomeCreatingStoreState({required super.stores});

  @override
  List<Object?> get props => [stores];
}

class HomeSearchingStoresState extends HomeState {
  const HomeSearchingStoresState({required super.stores, required this.query});
  final String query;

  @override
  List<Object?> get props => [stores, query];
}
