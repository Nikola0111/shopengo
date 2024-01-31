import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class InitializeTheme extends BottomNavigationEvent {
  const InitializeTheme();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class ToggleTheme extends BottomNavigationEvent {
  const ToggleTheme();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
