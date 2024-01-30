import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BuildTheme implements BottomNavigationEvent {
  @override
  List<Object> get props => throw UnimplementedError();

  @override
  bool? get stringify => false;
}
