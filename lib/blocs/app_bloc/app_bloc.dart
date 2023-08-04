import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/blocs/app_bloc/app_event.dart';
import 'package:shopengo/blocs/app_bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<LoadApp>((event, emit) async {
      // load theme and whatever else
      emit(AppLoaded());
    });
  }
}
