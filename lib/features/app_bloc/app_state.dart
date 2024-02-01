import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class AppLoaded extends AppState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
