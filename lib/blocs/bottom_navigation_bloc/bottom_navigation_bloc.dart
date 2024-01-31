import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_state.dart';
import 'package:shopengo/mixins/logger_mixin.dart';
import 'package:shopengo/services/appearance_service.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> with LoggerMixin {
  final _appearanceService = KiwiContainer().resolve<AppearanceService>();
  late ThemeData _theme;

  ThemeData get theme => _theme;

  BottomNavigationBloc() : super(const BottomNavigationInitial()) {
    on<BuildTheme>((event, emit) async {
      _theme = _appearanceService.buildTheme();
      emit(ThemeRebuilt(themeData: _theme));
    });
  }

  @override
  String get className => 'BottomNavigationBloc';
}
