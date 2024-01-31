import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:shopengo/blocs/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:shopengo/extensions/custom_colors.dart';

class HomePage extends StatelessWidget {
  static const pageName = 'home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primary,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<BottomNavigationBloc>().add(const ToggleTheme());
          },
          child: Text('Toggle theme'),
        ),
      ),
    );
  }
}
