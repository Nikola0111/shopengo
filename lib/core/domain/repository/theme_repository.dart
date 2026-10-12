import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:flutter/material.dart';

class ThemeRepository {
  final _colorScheme = const CustomColorScheme.classic();
  String? _appLogoSvgUrl;

  String? get appLogoSvgUrl => _appLogoSvgUrl;

  ThemeData buildTheme() {
    final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(
      primaryTextColor: _colorScheme.primaryText!,
    );
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Rubik',
      appBarTheme: AppBarTheme(backgroundColor: _colorScheme.background),
      extensions: <ThemeExtension<dynamic>>[_colorScheme, textStyleScheme],
    );
  }
}
