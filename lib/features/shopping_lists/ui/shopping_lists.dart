import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/extensions/custom_colors.dart';
import 'package:shopengo/features/bottom_navigation_container/bloc/bottom_navigation_bloc.dart';
import 'package:shopengo/features/bottom_navigation_container/bloc/bottom_navigation_event.dart';

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
          child: const Text('Toggle theme'),
        ),
      ),
    );
  }
}
