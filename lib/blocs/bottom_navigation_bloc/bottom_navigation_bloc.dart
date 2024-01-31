import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_state.dart';
import 'package:shopengo/mixins/logger_mixin.dart';
import 'package:shopengo/services/appearance_service.dart';

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
