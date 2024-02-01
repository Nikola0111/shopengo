import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/mixins/logger_mixin.dart';
import 'package:shopengo/core/services/appearance_service.dart';
import 'package:shopengo/features/bottom_navigation_container/bloc/bottom_navigation_event.dart';
import 'package:shopengo/features/bottom_navigation_container/bloc/bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> with LoggerMixin {
  final _appearanceService = KiwiContainer().resolve<AppearanceService>();

  BottomNavigationBloc() : super(const BottomNavigationInitial()) {
    on<InitializeTheme>((event, emit) {
      emit(ThemeUpdated(themeData: _appearanceService.buildTheme()));
    });

    on<ToggleTheme>((event, emit) {
      emit(ThemeUpdated(themeData: _appearanceService.toggleTheme()));
    });
  }

  @override
  String get className => 'BottomNavigationBloc';
}
