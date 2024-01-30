import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationInitial implements BottomNavigationState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class ThemeRebuilt implements BottomNavigationState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}