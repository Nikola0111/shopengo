import 'package:flutter/material.dart';
import 'package:shopengo/extensions/custom_colors.dart';

class HomePage extends StatelessWidget {
  static const pageName = 'home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primary,
    );
  }
}
