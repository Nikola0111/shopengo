import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_state.dart';

class BottomNavigationContainer extends StatelessWidget {
  final Widget child;
  const BottomNavigationContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBloc()..add(const ToggleTheme()),
      child: BlocSelector<BottomNavigationBloc, BottomNavigationState, ThemeData?>(
        selector: (state) {
          if (state is ThemeUpdated) {
            return state.themeData;
          }
          return null;
        },
        builder: (context, themeData) {
          if (themeData == null) return Container(); // splash screen
          return Theme(data: themeData, child: child);
        },
      ),
    );
  }
}
