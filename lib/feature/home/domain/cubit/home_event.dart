import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadStoresEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class StoresFetchedEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeCreatingStoreEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeSubmitNewStoreEvent extends HomeEvent {
  new({required this.storeName});
  final String storeName;

  @override
  List<Object?> get props => [storeName];
}

class HomeQueryStoresEvent extends HomeEvent {
  new({required this.query});
  final String? query;

  @override
  List<Object?> get props => [query];
}
