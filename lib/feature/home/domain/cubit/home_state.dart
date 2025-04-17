import 'package:equatable/equatable.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class StoresReadyEvent extends HomeState {
  StoresReadyEvent(this.stores);
  final List<StoreModel> stores;

  @override
  List<Object?> get props => [stores];
}
