import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class LoadApp implements AppEvent {
  @override
  List<Object> get props => throw UnimplementedError();

  @override
  bool? get stringify => false;
}