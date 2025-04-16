import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

enum AppThemeMode {
  light('light');

  const AppThemeMode(this.value);
  factory AppThemeMode.from(String value) {
    if (value == light.name) {
      return AppThemeMode.light;
    }
    throw Exception('theme not found for string: $value');
  }

  final String value;
}

class ThemeRepository {
  final AppThemeMode _appTheme = AppThemeMode.light;
  AppThemeMode get appTheme => _appTheme;
  final _colorScheme = CustomColorScheme.classic();
  String? _appLogoSvgUrl;

  String? get appLogoSvgUrl => _appLogoSvgUrl;

  ThemeData buildTheme() {
    final ThemeData theme;
    switch (_appTheme) {
      case AppThemeMode.light:
        final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(primaryTextColor: _colorScheme.primary!);
        theme = ThemeData(
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(color: _colorScheme.primary),
          fontFamily: 'Exo2',
          extensions: <ThemeExtension<dynamic>>[_colorScheme, textStyleScheme],
        );
    }

    return theme;
  }
}
