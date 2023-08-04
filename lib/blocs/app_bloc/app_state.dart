import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial implements AppState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class AppLoaded implements AppState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
