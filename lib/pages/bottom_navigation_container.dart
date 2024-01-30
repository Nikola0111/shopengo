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
      create: (context) => BottomNavigationBloc()..add(BuildTheme()),
      child: BlocSelector<BottomNavigationBloc, ThemeRebuilt, ThemeData>(
        selector: (state) => state.theme, builder: (context, state) => child,
      ),
    );
  }
}
